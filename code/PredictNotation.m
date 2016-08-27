function [ predict, label]= PredictNotation( block, labelcoord, model, transMatrix)

for i= 1: length( block)
    img= reshape( block{ i}, [ 1, 10000]);
    img= img*transMatrix;
    [ predict( i), ~, ~] = svmpredict(9, img, model);
    %     predict=14;
    switch  predict( i)
        case 1
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'-','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='-';
        case 2
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'(','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='(';
        case 3
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),')','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=')';
        case 4
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'+','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='+';
        case 5
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'=','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='=';
        case 6
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'0','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=0;
        case 7
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'1','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=1;
        case 8
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'2','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=2;
        case 9
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'3','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=3;
        case 10
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'4','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=4;
        case 11
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'5','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=5;
        case 12
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'6','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=6;
        case 13
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'7','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=7;
        case 14
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'8','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=8;
        case 15
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'9','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}=9;
        case 16
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'m','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='m';
        case 17
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'n','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='n';
        case 18
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'x','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='x';
        case 19
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'\Pi','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='{';
        case 20
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'\Sigma','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='}';
        case 21
            text( labelcoord{ i}( 1), labelcoord{ i}( 2),'\Sqrt','Color','g','FontSize',17,'HorizontalAlignment','right');
            label{ i}='~';
            
    end
end

end