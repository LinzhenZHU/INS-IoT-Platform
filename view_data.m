%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%> @file view_data.m  
%>
%> @brief Script for plotting the data from the zero-velocity aided inertial
%> navigations system.
%>
%> @authors Isaac Skog, John-Olof Nilsson
%> @copyright Copyright (c) 2011 OpenShoe, ISC License (open source)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global simdata;


% Close all windows
close all

% Generate a vector with the time scale
N=length(cov);
t=0:simdata.Ts:(N-1)*simdata.Ts;




%% Plot the trajectory in the horizontal plane
figure(2)
clf
plot(x_h(2,:),x_h(1,:))
hold
plot(x_h(2,1),x_h(1,1),'rs')
title('Trajectory')
legend('Trajectory','Start point')
xlabel('x [m]')
ylabel('y [m]')
axis equal
grid on
box on








