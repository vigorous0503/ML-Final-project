function ans_sigma =Dosigma( inbracket, index_inbracket, mid_row, start_row, end_row)

index_empty= find( cellfun(@isempty,inbracket)==1);% delete empty entry
inbracket(index_empty)={[] }; 
index_inbracket( index_empty)= 0; 
mid_row( index_empty)= 0; 
start_row( index_empty)= 0; 
end_row( index_empty)= 0; 

mid_row_sigma= mid_row( index_inbracket);
start_row_sigma= start_row( index_inbracket);
end_row_sigma= end_row( index_inbracket);
index_sigma= find(cellfun(@(x) x=='}', inbracket)==1);
% index_sigma_up= [];
index_sigma_up= find( start_row_sigma( index_sigma)>end_row_sigma); % up index is lower than the ceil of sigma
sigma_up= DoArithmetic( inbracket(  index_sigma_up), mid_row( index_sigma_up), start_row_sigma(  index_sigma_up), end_row_sigma(  index_sigma_up));
% index_sigma_down= [];
index_sigma_down= find( end_row_sigma( index_sigma)<mid_row_sigma); % down index is higher than the bottom of sigma
sigma_down= inbracket( index_sigma_down);
sigma_down{ 1}= 'm';    % let the parameter always be 'm'
% index_numeric_down= find( cellfun(@isnumeric, sigma_down)==1);
index_down= ( 1 : length( sigma_down)); % generate the sigma down index
index_numeric_down= index_down( 3:end);
mid_row_down= mid_row_sigma( index_sigma_down);
start_row_down= start_row_sigma( index_sigma_down);
end_row_down= end_row_sigma( index_sigma_down);
sigma_down{ index_numeric_down( 1)}= DoArithmetic( sigma_down( index_numeric_down), mid_row_down( index_numeric_down), ...
    start_row_down( index_numeric_down), end_row_down( index_numeric_down));
sigma_down= sigma_down(~cellfun(@isempty,sigma_down));

inbracket( index_sigma_down)={ [] };
inbracket( index_sigma_up)={ [] };
inbracket( index_sigma)={ [] };
sigma_oper= inbracket(~cellfun(@isempty,inbracket));
mid_row_sigma= mid_row_sigma( ~cellfun(@isempty,inbracket));
start_row_sigma= start_row_sigma( ~cellfun(@isempty,inbracket));
end_row_sigma= end_row_sigma( ~cellfun(@isempty,inbracket));
ans_sigma=0;
issqrt= ( cellfun(@(x) x=='~', sigma_oper)==1);
index_para= find( ( cellfun(@(x) x=='m', sigma_oper) + cellfun(@(x) x=='n', sigma_oper))==1);
for m=  sigma_down{ end}: sigma_up % do sigma arithmetic
   
    sigma_oper{ index_para}= m;
    if sum( issqrt)~=0    %have sqrt
        
%         temp= pi_oper{ issqrt==0};
%         mid_row=mid_row_sigma{ issqrt==0};
%         start_row= start_row_sigma{ issqrt==0};
%         end_row= end_row_sigma{ issqrt==0};
        ans_sigma= DoArithmetic( temp, mid_row, start_row, end_row)*ans_pi;
    else
        ans_sigma= DoArithmetic( sigma_oper, mid_row_sigma, start_row_sigma, end_row_sigma) +ans_sigma;
    end
    
end