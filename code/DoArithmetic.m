function ans_label= DoArithmetic( label, mid_row, start_row, end_row)

while 1     % avoid double up bracket, so must update
    
    islbracket= find(cellfun(@(x) x=='(', label)==1);
    isrbracket= find(cellfun(@(x) x==')', label)==1);
    if isempty( isrbracket)
        break;
    end
    if length( islbracket)==1   % only 1 bracket
        
        index_inbracket=  islbracket( 1 )+1: isrbracket( 1)-1 ;
        inbracket= label( index_inbracket);
        if sum( find(cellfun(@(x) x=='}', inbracket)==1))~=0
            
            ans_sigma =Dosigma( inbracket, index_inbracket, mid_row, start_row, end_row) ;
            
            label{ isrbracket( 1)}= ans_sigma;
            
            label( index_inbracket)= { [] };
            label( islbracket( 1))= { [] };
            mid_row( index_inbracket)=  0 ;
            mid_row( islbracket( 1))= 0;
            start_row( index_inbracket)=  0 ;
            start_row( islbracket( 1))= 0;
            end_row( index_inbracket)=  0 ;
            end_row( islbracket( 1))= 0;
            label= label(~cellfun(@isempty,label)); % delete empty entry
            mid_row( mid_row==0)= [];   % % delete empty entry
            start_row( start_row==0)= [];   % % delete empty entry
            end_row( end_row==0)= [];   % % delete empty entry
        elseif  sum( find(cellfun(@(x) x=='{', inbracket)==1))~=0
            ans_pi =Dopi( inbracket, index_inbracket, mid_row, start_row, end_row) ;
            label{ isrbracket( 1)}= ans_pi;
            
            label( index_inbracket)= { [] };
            label( islbracket( 1))= { [] };
            mid_row( index_inbracket)=  0 ;
            mid_row( islbracket( 1))= 0;
            start_row( index_inbracket)=  0 ;
            start_row( islbracket( 1))= 0;
            end_row( index_inbracket)=  0 ;
            end_row( islbracket( 1))= 0;
            label= label(~cellfun(@isempty,label)); % delete empty entry
            mid_row( mid_row==0)= [];   % % delete empty entry
            start_row( start_row==0)= [];   % % delete empty entry
            end_row( end_row==0)= [];   % % delete empty entry
        else
            ans_inbracket = DoArithmetic( inbracket, mid_row( index_inbracket), start_row( index_inbracket), end_row( index_inbracket) );
            label{ isrbracket( 1)}= ans_inbracket;
            label( index_inbracket)= { [] };
            label( islbracket( 1))= { [] };
            mid_row( index_inbracket)=  0 ;
            mid_row( islbracket( 1))= 0;
            label= label(~cellfun(@isempty,label)); % delete empty entry
            mid_row( mid_row==0)= [];   % % delete empty entry
        end
    elseif islbracket( 2)== islbracket( 1)+1    % succecssive bracket
        
        index_inbracket=  islbracket( end )+1: isrbracket( 1)-1 ;
        inbracket= label( index_inbracket);
        ans_inbracket = DoArithmetic( inbracket, mid_row( index_inbracket), start_row( index_inbracket), end_row( index_inbracket) );
        label{ isrbracket( 1)}= ans_inbracket;
        label( index_inbracket)= { [] };
        label( islbracket( end))= { [] }; %%%%%%%%%%
        mid_row( index_inbracket)=  0 ;
        mid_row( islbracket( 1))= 0;
        
        label= label(~cellfun(@isempty,label)); % delete empty entry
        mid_row( mid_row==0)= [];   % % delete empty entry
    else        %   many bracket, but not successive
        index_inbracket=  islbracket( 1 )+1: isrbracket( 1)-1 ;
        inbracket= label( index_inbracket);
        
        if sum( find(cellfun(@(x) x=='}', inbracket)==1))~=0    % sigma
            
            ans_sigma =Dosigma( inbracket, index_inbracket, mid_row, start_row, end_row) ;
            label{ isrbracket( 1)}= ans_sigma;
            label( index_inbracket)= { [] };
            label( islbracket( 1))= { [] };
            mid_row( index_inbracket)=  0 ;
            mid_row( islbracket( 1))= 0;
            start_row( index_inbracket)=  0 ;
            start_row( islbracket( 1))= 0;
            end_row( index_inbracket)=  0 ;
            end_row( islbracket( 1))= 0;
            label= label(~cellfun(@isempty,label)); % delete empty entry
            mid_row( mid_row==0)= [];   % % delete empty entry
            start_row( start_row==0)= [];   % % delete empty entry
            end_row( end_row==0)= [];   % % delete empty entry
            
        elseif  sum( find(cellfun(@(x) x=='{', inbracket)==1))~=0   % pi
            ans_pi =Dopi( inbracket, index_inbracket, mid_row, start_row, end_row) ;
            label{ isrbracket( 1)}= ans_pi;
            
            label( index_inbracket)= { [] };
            label( islbracket( 1))= { [] };
            mid_row( index_inbracket)=  0 ;
            mid_row( islbracket( 1))= 0;
            start_row( index_inbracket)=  0 ;
            start_row( islbracket( 1))= 0;
            end_row( index_inbracket)=  0 ;
            end_row( islbracket( 1))= 0;
            label= label(~cellfun(@isempty,label)); % delete empty entry
            mid_row( mid_row==0)= [];   % % delete empty entry
            start_row( start_row==0)= [];   % % delete empty entry
            end_row( end_row==0)= [];   % % delete empty entry
            
        else
            %             index_inbracket=  islbracket( 1 )+1: isrbracket( 1)-1 ;
            %             inbracket= label( index_inbracket);
            ans_inbracket = DoArithmetic( inbracket, mid_row( index_inbracket), start_row( index_inbracket), end_row( index_inbracket) );
            label{ isrbracket( 1)}= ans_inbracket;
            label( index_inbracket)= { [] };
            label( islbracket( 1))= { [] };
            mid_row( index_inbracket)=  0 ;
            mid_row( islbracket( 1))= 0;
            
            label= label(~cellfun(@isempty,label)); % delete empty entry
            mid_row( mid_row==0)= [];   % % delete empty entry
        end
    end
end
label= label(~cellfun(@isempty,label)); % delete empty entry
mid_row( mid_row==0)= [];   % % delete empty entry
start_row( start_row==0)= [];   % % delete empty entry
end_row( end_row==0)= [];   % % delete empty entry

% no bracket, but  have 'sigma' or 'pi' or 'sqrt', so must do first, come them
if sum( find(cellfun(@(x) x=='}', label)==1))~=0    %sigma
    index_label= 1:length( label);
    ans_sigma =Dosigma( label, index_label, mid_row, start_row, end_row) ;
    label{ 1}= ans_sigma;
    label( index_label( 2:length( label)))= { [] };
    mid_row( index_label( 2:length( label)))=  0 ;
    start_row( index_label( 2:length( label)))=  0 ;
    end_row( index_label( 2:length( label)))=  0 ;
    label= label(~cellfun(@isempty,label)); % delete empty entry
    mid_row( mid_row==0)= [];   % % delete empty entry
    start_row( start_row==0)= [];   % % delete empty entry
    end_row( end_row==0)= [];   % % delete empty entry
    
elseif  sum( find(cellfun(@(x) x=='{', label)==1))~=0   %pi
    index_label= 1:length( label);
    ans_pi =Dopi( label, index_label, mid_row, start_row, end_row) ;
    label{ 1}= ans_pi;
    label( index_label( 2:length( label)))= { [] };
    mid_row( index_label( 2:length( label)))=  0 ;
    start_row( index_label( 2:length( label)))=  0 ;
    end_row( index_label( 2:length( label)))=  0 ;
    label= label(~cellfun(@isempty,label)); % delete empty entry
    mid_row( mid_row==0)= [];   % % delete empty entry
    start_row( start_row==0)= [];   % % delete empty entry
    end_row( end_row==0)= [];   % % delete empty entry
    
    %   elseif sum( find (cellfun(@(x) x=='~', inbracket)==1))~=0; % sqrt
    %     issqrt= ( cellfun(@(x) x=='}', label)==1);
    
end

% issqrt= ( cellfun(@(x) x=='}', label)==1);


isoperation= cellfun(@ischar, label); % the index of operation
index_sqrt=  find( ( cellfun(@(x) x=='~', label)) ==1);
isoperation( index_sqrt)= 0;
if sum( isoperation)==0 %  no operation in label
    
    group_mid_row= mid_row;    % the position of the labels between (beside ) operation
    issqrt= ( cellfun(@(x) x=='~', label)==1);
    if sum( issqrt)==1
        group= label( ~issqrt);  % the labels between (beside ) operation
        group_mid_row= group_mid_row( ~issqrt);
    else
        group= label;
    end
    group= cell2mat( group);
    %     group_mid_row= mid_row;    % the position of the labels between (beside ) operation
    distance= abs( group_mid_row-group_mid_row( 1));    % the distance according the first label of group
    index_superscript= double( distance>10);  %   exponential index is ' 1'  , basis index is ' 0 '
    basis= group( index_superscript==0);
    carry= length(basis);   % judge digit
    temp2=0;
    for j= 1: carry
        temp2= basis( end- j+1)*(10^(j-1))+ temp2;
    end
    basis= temp2;
    if sum( index_superscript==1)>0 %   judge if there is superscript or not
        superscript= group( index_superscript==1);
        carry= length( superscript);    % judge digit
        temp2=0;
        for j= 1: carry
            temp2= superscript( end- j+1)*(10^(j-1))+ temp2;
        end
        superscript= temp2;
        ans_exp= basis^superscript;
    else  % no superscript
        
        ans_exp= basis;
    end
    if sum( issqrt)==1
        ans_exp= sqrt( ans_exp);  % the labels between (beside ) operation
        
    end
    label{ 1}= ans_exp;
    label( 2 : length( label))= [];
    
    
else % have operation
    for k=1: sum( isoperation)  %  number of operation in label
        
        index_oper= find( isoperation==1);
        
        if k==1
            if label{ 1}=='-'   % if label is nagative
                
                group= label( index_oper( end)+1 : end);
                group_mid_row= mid_row( index_oper( end)+1 : end);
            else
                
                
                group= label( 1: index_oper( k)-1);  % the labels between (beside ) operation
                group_mid_row= mid_row( 1: index_oper( k)-1);    % the position of the labels between (beside ) operation
                issqrt= ( cellfun(@(x) x=='~', group)==1);
                if sum( issqrt)==1
                    group= group( ~issqrt);
                    group_mid_row= group_mid_row( ~issqrt);
                    %                     group_mid_row= mid_row( 1: index_oper( k)-1);    % the position of the labels between (beside ) operation
                end
                %                 group= label( 1: index_oper( k)-1);  % the labels between (beside ) operation
                %                 group_mid_row= mid_row( 1: index_oper( k)-1);    % the position of the labels between (beside ) operation
            end
        else
            group= label( index_oper( k-1)+1 : index_oper( k)-1);
            group_mid_row= mid_row( index_oper( k-1)+1 : index_oper( k)-1);
            issqrt= ( cellfun(@(x) x=='}', group)==1);
            if sum( issqrt)==1
                group= group( ~issqrt);
                group_mid_row= group_mid_row( ~issqrt);
                %                     group_mid_row= mid_row( 1: index_oper( k)-1);    % the position of the labels between (beside ) operation
            end
        end
        group= cell2mat( group);
        
        distance= abs( group_mid_row-group_mid_row( 1));    % the distance according the first label of group
        index_superscript= double(  distance>10);  %   exponential index is ' 1'  , basis index is ' 0 '
        basis= group( index_superscript==0);
        carry= length(basis);   % judge digit
        temp2=0;
        for j= 1: carry
            temp2= basis( end- j+1)*(10^(j-1))+ temp2;
        end
        basis= temp2;
        if sum( index_superscript==1)>0 %   judge if there is superscript or not
            superscript= group( index_superscript==1);
            carry= length( superscript);    % judge digit
            temp2=0;
            for j= 1: carry
                temp2= superscript( end- j+1)*(10^(j-1))+ temp2;
            end
            superscript= temp2;
            ans_exp= basis^superscript;
        else
            
            ans_exp= basis;
        end
        if sum( issqrt)==1
            ans_exp= sqrt( ans_exp);  % the labels between (beside ) operation
        end
        
        if k==1
            if label{ 1}=='-'   % if label is nagative
                label{ 1}= -1*ans_exp;
                label( 2 : end)= { [] };
            else
                label{ 1}= ans_exp;
                label( 2 : index_oper( k)-1)= { [] };
            end
        else
            
            label{ index_oper( k-1)+1}= ans_exp;
            label(  index_oper( k-1) +2 : index_oper( k)-1)= { [] };
        end
    end
end
%   the last of formula( besides the operaton) at right

if length( label(~cellfun(@isempty,label)))~=1  % if label is nagative, then length= 1
    
    group= label( index_oper( end)+1 : end);
    group_mid_row= mid_row( index_oper( end)+1 : end);
    issqrt= ( cellfun(@(x) x=='~', group)==1);
    if sum( issqrt)==1
        group= group( ~issqrt);
        group_mid_row= group_mid_row( ~issqrt);
        %                     group_mid_row= mid_row( 1: index_oper( k)-1);    % the position of the labels between (beside ) operation
    end
    group= cell2mat( group);
    
    distance= abs( group_mid_row-group_mid_row( 1));    % the distance according the first label of group
    index_superscript= double(  distance>16);  %   exponential index is ' 1'  , basis index is ' 0 '
    basis= group( index_superscript==0);
    carry= length(basis);   % judge digit
    temp2=0;
    for j= 1: carry
        temp2= basis( end- j+1)*(10^(j-1))+ temp2;
    end
    basis= temp2;
    if sum( index_superscript==1)>0 %   judge if there is superscript or not
        superscript= group( index_superscript==1);
        carry= length( superscript);    % judge digit
        temp2=0;
        for j= 1: carry
            
            temp2= superscript( end- j+1)*(10^(j-1))+ temp2;
        end
        superscript= temp2;
        ans_exp= basis^superscript;
    else
        
        ans_exp= basis;
    end
    if sum( issqrt)==1
        ans_exp= sqrt( ans_exp);  % the labels between (beside ) operation
    end
    label{ index_oper( end)+1}= ans_exp;
    label(  index_oper( end) +2 : end)= { [] };
end



label= label(~cellfun(@isempty,label)); % delete empty entry

% do operation in label
while 1
    if cellfun(@ischar, label)==0
        break;
    end
    if sum(cellfun(@(x) x=='x', label))>0
        
        isMul= find(cellfun(@(x) x=='x',label)==1);
        ans_mul= label{ isMul( 1)-1}*label{ isMul( 1)+1};
        label{ isMul( 1)-1}= ans_mul;
        label( isMul( 1): isMul( 1)+1)=[];
    elseif sum(cellfun(@(x) x=='+', label))>0
        
        isadd= find(cellfun(@(x) x=='+',label)==1);
        ans_add= label{ isadd( 1)-1}+label{ isadd( 1)+1};
        label{ isadd( 1)-1}= ans_add;
        label( isadd( 1): isadd( 1)+1)=[];
    elseif sum(cellfun(@(x) x=='-', label))>0
        
        if length( label)==2    %   if label is nagative
            
            ans_divi= -( label{ isdivi( 1)+1});
            label{ isdivi( 1)+1}= ans_divi;
        else
            
            isdivi= find(cellfun(@(x) x=='-',label)==1);
            ans_divi= label{ isdivi( 1)-1}-label{ isdivi( 1)+1};
            label{ isdivi( 1)-1}= ans_divi;
            label( isdivi( 1): isdivi( 1)+1)=[];
        end
    end
end

ans_label= cell2mat( label);


end