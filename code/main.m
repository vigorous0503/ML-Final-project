addpath('./libsvm-3.21/matlab/');
% clear all;
close all;
fold= './white_digit/normal/formulas/level_2/';

%% Data
% input the training and testing data
% train=load('Training_data.mat');
% test=load('test_data.mat');

% Training data
% X_train=train.data;    % put the X_train of train to data
% T_train=train.label;  % put the T_train of train to target

% % Test data
% X_test=test.test_data;    % put the X_test of test
% T_test=test.tr;    % put the X_test of test

%% Training model
% model_nu1 = svmtrain(T_train, X_train ,'-s 0 -t 2 -g 0.01');
% model_nu1= load( 'model.mat');
% model_nu1= load( 'model_del0.5.mat');
% model_nu1= model_nu1.model_nu1;
% model= load( 'combine_4_rotate.mat');
model= load( 'model_4.mat');
model_nu1= model.model_nu4;
% transMatrix= load('transMatrix.mat');
% transMatrix= transMatrix.transMatrix1;
transMatrix= model.transMatrix1;

%% Testing

imgList = dir( [fold '*.png']);
% answer= zeros( length( imgList), 1);

for num = 1 : length(imgList)
    
    no= imgList( num).name;
    no= strrep( no, 'valid_','' );
    no= str2double( strrep( no, '.png','' ));
    clear  labelcoord notation ratio len width mid_col end_col start_col mid_row centroid;
    name=  imgList(num).name;
    rgbdata= imread([fold name]);
    rgbdata( end-8: end, :, :)= 0;
    data= im2double( rgb2gray( rgbdata));
    %data= double( data>0.5);
    [ row, col ]= size( data);
    cc= bwconncomp( double( data>0.5), 4);
    cc1= bwlabel( double( data>0.5));
    figure,imshow( rgbdata),hold on;
    
    % rgbdata=
    % imread('./white_digit/normal/formulas/level_3/valid_17.png');
    % data= im2double( rgb2gray( rgbdata));
    % %data= double( data>0.5);
    % [ row, col ]= size( data);
    % cc= bwconncomp( double( data>0.5), 4);
    % cc1= bwlabel( double( data>0.5));
    % figure(1),imshow( rgbdata),hold on;
    
    % slice the digit
    for i= 1 : length( cc.PixelIdxList)
        
        y= floor(( cc.PixelIdxList{ i}-1)/row)+ 1;    % col
        x= cc.PixelIdxList{ i} - ( y-1)*row;  % row
        if (max( y)- min( y))<=9 &&  (max( x)- min( x))<=11 % remove noise
            cc.PixelIdxList{ i}= [];
            continue
        end
        ratio( i)= ( max(y)-min(y))/( max(x)-min(x));
        len( i)= max(y)-min(y);
        width( i)= max(x)-min(x);
        mid_col( i)= ( max(y)+min(y))/2;
        end_col( i)= max( y);
        start_col( i)= min( y);
        start_row( i)= min( x);
        end_row( i)= max( x);
        mid_row( i)= ( max( x)+min(x))/2; 
        centroid{ i}= [ mid_row( i), mid_col( i)];
        plot( [ min(y),  max(y),  max(y),  min(y),  min(y)], [ min(x), min(x), max(x),  max(x),  min(x)], ' c');
        blackboard= zeros( row, col);
        blackboard( cc.PixelIdxList{ i})= data( cc.PixelIdxList{ i});
        %         block{ i}= mat2gray( imresize( blackboard( min(x)-2:max(x)+2, min(y)-5:max(y)+5), [ 100, 100]));
        block= blackboard( min(x):max(x), min(y):max(y));
        imlarge=  floor( 100/max( size( block)));   % the ratio of imlarge
        if imlarge==1 && max( size( block))<50
            imlarge= imlarge+0.5;
        elseif imlarge==1 && max( size( block))>=50 && max( size( block))<70
            imlarge= imlarge+0.35;
        elseif imlarge==1 && max( size( block))>=70 && max( size( block))<95
            imlarge= imlarge+0.05;
        elseif imlarge==0   % the noation exceed 100*100
            imlarge=  fix( 100/max( size( block))*10)/10;   % the ratio of imlarge
        end
        block= imresize( block, imlarge);   % resize according to the ratio
        block= mat2gray( block); % normalize
        block( block<0.5)= 0;   %   reduce noise
        background= zeros( 100, 100);
        point_r= ceil( ( 100 - size( block, 1) )/2);   % the ( row) start point of block
        if point_r==0
            point_r= point_r+1;
        end
        point_c= ceil( ( 100 - size( block, 2) )/2);   % the ( col) start point of block
        if point_c==0
            point_c= point_c+1;
        end
        background(  point_r: point_r+ size( block, 1) - 1, point_c: point_c+ size( block, 2) - 1)= block;
        notation{ i}= background;
        labelcoord{ i}= [ min(y), min(x)];
        %     predict_label=
        %     text( min_y, min_x,'m','Color','r','FontSize',17,'HorizontalAlignment','right');
    end
    
    % remove empty element result in noise
    %     ratio(  ratio==0)= [];
    ratio(  ratio==0)= [];
    len(  len==0)= [];
    width(  width==0)= [];
    mid_col(  mid_col==0)= [];
    end_col(  end_col==0)= [];
    end_row(  end_row==0)= [];
    start_col(  start_col==0)= [];
    start_row( start_row==0)= [];
    mid_row(  mid_row==0)= [];
    %     ratio= block(~cellfun(@isempty,ratio));
    %     len= block(~cellfun(@isempty,len));
    %     width= block(~cellfun(@isempty,width));
    notation= notation(~cellfun(@isempty,notation));
    labelcoord= labelcoord(~cellfun(@isempty,labelcoord));
    cc.PixelIdxList= cc.PixelIdxList(~cellfun(@isempty,cc.PixelIdxList));
    centroid=  centroid(~cellfun(@isempty, centroid));
    %   combine "="
    %         equal_index= fliplr( find( ( 7>ratio{ num}).*( ratio{ num}>1.9))); %   from back to front
    %     equal_index= fliplr( find( ( width{ num}<=13).*( len{ num}<=65))); %   from back to front
    like_equal= find( ( ratio>=1.5).*( len<=60));    % first: compare ratio & length to get like equal
    %     position= mid_col{ num}( like_equal);   % second: consider their position
    position= end_col( like_equal);   % second: consider their position
    position1= start_col( like_equal);
    matrix= zeros( length( like_equal), length( like_equal));
    matrix1= zeros( length( like_equal), length( like_equal));
    for i= 1: length( position)
        matrix( i, :)= (abs( position-position( i))<=15).*( abs( position-position( i))>=0);
        matrix1( i, :)= (abs( position1-position1( i))<=15).*( abs( position1-position1( i))>=0);
    end
    equal_index= like_equal(  find( (sum( matrix, 1)>1).*(sum( matrix1, 1)>1)));
    %     equal_index= fliplr( find( ( ratio{ num}>1.5).*( len{ num}<=65))); %   from back to front
    
    for j=1 : floor( length( equal_index)/2)   %   be sure the index will pair
        
        cc.PixelIdxList{ equal_index( 2*j-1)}= [ cc.PixelIdxList{ equal_index( 2*j-1)}; cc.PixelIdxList{ equal_index( 2*j)}];
        %     cc.PixelIdxList{ equal_index( 2*j)}= [];
        notation{ equal_index( 2*j)}= [];   % assign 0 to the index which is be combine
        labelcoord{ equal_index( 2*j)}= [];
        centroid{ equal_index( 2*j)}= [];
        ratio( equal_index( 2*j))= 0;
        len(  equal_index( 2*j))= 0;
        width( equal_index( 2*j))= 0;
        mid_col( equal_index( 2*j))= 0;
        end_col( equal_index( 2*j))= 0;
        end_row( equal_index( 2*j))= 0;
        start_col( equal_index( 2*j))= 0;
        start_row( equal_index( 2*j))= 0;
        mid_row( equal_index( 2*j))= 0;
        
        y= floor(( cc.PixelIdxList{ equal_index( 2*j-1)}-1)/row)+ 1;    % col
        x= cc.PixelIdxList{ equal_index( 2*j-1)} - ( y-1)*row;  % row
        plot( [ min(y),  max(y),  max(y),  min(y),  min(y)], [ min(x), min(x), max(x),  max(x),  min(x)], 'm--');
        ratio( equal_index( 2*j-1))= ( max(y)-min(y))/( max(x)-min(x)); % update the combine information
        width( equal_index( 2*j-1))= max(x)-min(x);
        len(  equal_index( 2*j-1))= max(y)-min(y);
        mid_col( equal_index( 2*j-1))= ( max(y)+min(y))/2;
        end_col( equal_index( 2*j-1))= max( y);
        start_col( equal_index( 2*j-1))= min( y);
        mid_row( equal_index( 2*j-1))= ( max( x)+min(x))/2;
        centroid{ equal_index( 2*j-1)}= [ mid_row( equal_index( 2*j-1)), mid_col( equal_index( 2*j-1))];
        
        blackboard= zeros( row, col);
        blackboard( cc.PixelIdxList{ equal_index( 2*j-1)})=  data( cc.PixelIdxList{ equal_index( 2*j-1)});
        %         block{ equal_index( 2*j-1)}= mat2gray( imresize( blackboard( min(x)-2:max(x)+2, min(y)-5:max(y)+5), [ 100, 100]));
        block= blackboard( min(x):max(x), min(y):max(y));
        imlarge=  floor( 100/max( size( block)));   % the ratio of imlarge
        if imlarge==1 && max( size( block))<50
            imlarge= imlarge+0.5;
        elseif imlarge==1 && max( size( block))>=50 && max( size( block))<70
            imlarge= imlarge+0.35;
        elseif imlarge==1 && max( size( block))>=70 && max( size( block))<95
            imlarge= imlarge+0.05;
        elseif imlarge==0   % the noation exceed 100*100
            imlarge=  fix( 100/max( size( block))*10)/10;   % the ratio of imlarge
        end
        block= imresize( block, imlarge);   % resize according to the ratio
        block= mat2gray( block); % normalize
        block( block<0.5)= 0;   %   reduce noise
        background= zeros( 100, 100);
        point_r= ceil( ( 100 - size( block, 1) )/2);   % the ( row) start point of block
        if point_r==0
            point_r= point_r+1;
        end
        point_c= ceil( ( 100 - size( block, 2) )/2);   % the ( col) start point of block
        if point_c==0
            point_c= point_c+1;
        end
        background(  point_r: point_r+ size( block, 1) - 1 , point_c: point_c+ size( block, 2) - 1)= block;
        notation{ equal_index( 2*j-1)}= background;
        labelcoord{ equal_index( 2*j-1)}= [ min(y), min(x)];
    end
    notation= notation(~cellfun(@isempty,notation));    %   delete the index which is be combined
    labelcoord = labelcoord(~cellfun(@isempty,labelcoord));
    centroid= centroid(~cellfun(@isempty,centroid));
    ratio( ratio==0)= [];
    len(  len==0)= [];
    width( width==0)= [];
    mid_col( mid_col==0)= [];
    start_col( start_col==0)= [];
    start_row( start_row==0)= [];
    end_col( end_col==0)= [];
    end_row( end_row==0)= [];
    mid_row( mid_row==0)= [];
    
    %% Predict label
    
    [ predict, label]= PredictNotation( notation, labelcoord, model_nu1, transMatrix);
    hold off;
    %     label{ 2}='-'; label{ 3}=7;label{ 4}=')';
    %% do operation

    islike_frac= find( ( ratio>=1.5).*( width<=27));  % the index which may be '-' & 'frac'
    
    isfrac= [];
    for i= 1: length( islike_frac)
        
        index_infrac= find( ( mid_col>start_col( islike_frac( i))).* ( mid_col<end_col( islike_frac( i)))); % find the digit include like_frac
        index_infrac( index_infrac==islike_frac( i))= [];
        index_frac_up= [];
        index_frac_up=  index_infrac(  mid_row( index_infrac)<mid_row( islike_frac( i)));   % check frac_1        mid_row
        index_frac_down= [];
        index_frac_down= index_infrac(  mid_row( index_infrac)>mid_row( islike_frac( i)));  % check frac_2       mid_row
        if isempty( index_frac_down) || isempty( index_frac_up) % delete non-frac
            continue;
        end
        isfrac=  [ isfrac, islike_frac( i)]; % real frac_index
        
        ans_frac_up= DoArithmetic( label( index_frac_up),mid_row( index_frac_up),start_row( index_frac_up),end_row( index_frac_up));
        ans_frac_down= DoArithmetic( label( index_frac_down),mid_row( index_frac_down),start_row( index_frac_down),end_row( index_frac_up));
        ans_frac= ans_frac_up/ans_frac_down;
        label{ islike_frac( i)}= ans_frac;
        label( index_infrac)= { [] };
    end
    index_desire= (~cellfun(@isempty, label));
    index_process= find( index_desire( 1: end-1));
    % do final arithmetic
    ans_exp = DoArithmetic( label(index_desire( 1:end-1)), mid_row( index_desire( 1: end-1)), start_row( index_desire( 1: end-1)), end_row( index_desire( 1: end-1)));
    label{ index_process( end)}= ans_exp;
    label( index_process( 1: end-1))= { [] };
    if length( label(~cellfun(@isempty,label)))==2
        
        label= label(~cellfun(@isempty,label));
        ans_final= label{ end-1};
        text( labelcoord{ end}( 1)+80, labelcoord{ end}( 2)+10, int2str( ans_final),'Color','r','FontSize',40,'HorizontalAlignment','center');
        answer( no)= ans_final;
    end
    
    
    
    pause;
    if num== length(imgList)
        break;
    end
    %
    %
    %
end

real_ans=  load( [fold,'T_valid']);
real_ans= real_ans.T_valid;
accuracy= sum( ( real_ans-answer)==0)/30;
save_fold= [ fold,'Y_test'];
% save save_fold answer;
save Y_test answer;

