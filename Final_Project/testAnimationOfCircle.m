c = [0 0] ;   % center of circle
th = linspace(0,2*pi) ;
r = 0.1;
x = c(1)+r*cos(th) ;
y = c(1)+r*sin(th) ;
h = plot(x,y,'r') ;
axis equal 
%%animation
a = tic; % start timer
totalTime = 10;
numpoints = 100;
d = 2;
for i = 1:numpoints
    c = rand(1,2) ;  % center of circle
      x = c(1)+r*cos(th) ;
      y = c(2)+r*sin(th) ;
      set(h,'XData',x,'YData',y) ;
      axis([-d d -d d])    
        b = toc(a); % check timer
        while b < totalTime/numpoints
            %disp('did it do anything');
            drawnow % update screen every 1/30 seconds
            b = toc(a); % check timer
        end
        a = tic; % reset timer after updating    
        disp(i);
  end