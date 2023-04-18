function resetSoccer(soccer,Xdata,Ydata)
   set( soccer.bodyHandle, 'Xdata', Xdata,'Ydata',  Ydata);
   set( soccer.headHandle, 'Xdata', Xdata+20, 'Ydata', Ydata+20);
end