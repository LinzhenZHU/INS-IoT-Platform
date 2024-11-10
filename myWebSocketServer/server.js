const WebSocket = require('ws'); // 引入WebSocket库 / Import the WebSocket library
const fs = require('fs'); // 引入文件系统模块 / Import the file system module
const csv = require('csv-parser'); // 引入csv解析器 / Import the CSV parser
const wss = new WebSocket.Server({ port: 8080 }); // 创建WebSocket服务器，监听8080端口 / Create a WebSocket server listening on port 8080

// 定义要读取的CSV文件列表 / Define the list of CSV files to read
const csvFiles = [
  '/Users/nextop/Documents/MATLAB/A.csv',
  '/Users/nextop/Documents/MATLAB/B.csv',
  '/Users/nextop/Documents/MATLAB/C.csv'
];
const colors = ['#ff0000', '#CD950C', '#0000ff']; // 分配不同的颜色给每个轨迹 / Assign different colors to each trajectory

const initialCoordinateX=24;
const initialCoordinateY=19;
const initialCoordinateZ=5;

// 定义一个函数，读取CSV文件并发送数据 / Define a function to read CSV files and send data
const readCSVAndSend = (ws) => {
  // 使用Promise.all并行读取所有CSV文件 / Use Promise.all to read all CSV files in parallel
  Promise.all(csvFiles.map((file, index) =>
    new Promise((resolve) => {
      const results = [];
      fs.createReadStream(file)
        .pipe(csv())
        .on('data', (data) => results.push([parseFloat(data.x)+initialCoordinateX, parseFloat(data.y)+initialCoordinateY, 0.1])) // 读取并解析每一行数据，转换为浮点数 / Read and parse each line of data, convert to float
        .on('end', () => {
          const lastThreePoints = results;
          resolve({ points: lastThreePoints, color: colors[index] });
        });
    })
  )).then((trajectoriesData) => {
    ws.send(JSON.stringify(trajectoriesData)); // 将数据序列化为JSON格式并发送 / Serialize data to JSON format and send
  });
};

// 当有客户端连接时 / When a client connects
wss.on('connection', (ws) => {
  console.log('Client connected'); // 打印“客户端已连接” / Print "Client connected"
  readCSVAndSend(ws); // 初始发送 / Send data initially

  // 定时发送更新的数据 / Periodically send updated data
  const intervalId = setInterval(() => readCSVAndSend(ws), 1000); // 每1秒更新一次 / update every second

  // 当客户端关闭连接时 / When the client closes the connection
  ws.on('close', () => {
    console.log('Client disconnected'); // 打印“客户端已断开连接” / Print "Client disconnected"
    clearInterval(intervalId); // 清除定时器 / Clear the interval
  });
});
