load  Seizure_Timesig_Sub_uni10.mat;
[m n] =size(C);
node=1:1:n;
MM=5000;
k=1;
 for p=1:10:length(node)
  
QQ=[];ZZ=[];
     
X1=C(1:MM,node(p));
len=length(C);
T1=(1:MM)/200;
X2=C(MM+1:end-MM,node(p));
T2=(MM+1:length(C)-MM)/200;
X3=C(end-MM:end,node(p));
T3=(length(C)-MM:length(C))/200;
subplot(5,1,k); 
   k=k+1;
%subplot(length(node),1,length(node)-(p)+1); 
% figure;  
 plot(T1(1:4000),X1(1:4000)','b', 'linewidth',2);
 hold on;
 plot(T1(4001:5000),X1(4001:5000)','g', 'linewidth',2)
  plot(T2,X2','r', 'linewidth',2);
 hold on;
 plot(T3(1:2000),X3(1:2000)','g', 'linewidth',2);
  plot(T3(2001:5000),X3(2001:5000)','b', 'linewidth',2);
 hold on;
    ylabel('$V$','Interpreter','LaTeX','FontSize',20)
   set(gca,'XTick',[]);
   hold on;
   
   set(gca,'ticklength',0.25*get(gca,'ticklength'))
   axis tight;
 hold on  
 axis off;
 end 
hold on;

set(gca,'XTick',[0:25:floor(len/200)]);
set(gcf, 'PaperPositionMode', 'auto','position', [0, 0, 850, 850]);
set(findall(gcf,'-property','FontSize'),'FontName','Cambria','FontSize',6,'linewidth',1.0)%,'fontweight','b') ;
set(gcf,'InvertHardCopy','off','Color','white');
xlabel('$t(s)$','Interpreter','LaTeX','FontSize',20)

