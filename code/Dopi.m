function ans_pi =Dopi( inbracket, index_inbracket, mid_row, start_row, end_row)

index_empty= find( cellfun(@isempty,inbracket)==1);% delete empty entry
inbracket(index_empty)={[] }; 
index_inbracket( index_empty)= 0; 
mid_row( index_empty)= 0; 
start_row( index_empty)= 0; 
end_row( index_empty)= 0; 

mid_row_pi= mid_row( index_inbracket);
start_row_pi= start_row( index_inbracket);
end_row_pi= end_row( index_inbracket);
index_pi= find(cellfun(@(x) x=='{', inbracket)==1);
% index_pi_up= [];
index_pi_up= find( start_row_pi( index_pi)>end_row_pi); % up index is lower than the ceil of pi
pi_up= DoArithmetic( inbracket(  index_pi_up), mid_row( index_pi_up), start_row_pi(  index_pi_up), end_row_pi(  index_pi_up));
% index_pi_down= [];
index_pi_down= find( end_row_pi( index_pi)<mid_row_pi); % down index is higher than the bottom of pi
pi_down= inbracket( index_pi_down);
pi_down{ 1}= 'm';    % let the parameter always be 'm'
% index_numeric_down= find( cellfun(@isnumeric, pi_down)==1);
index_down= ( 1 : length( pi_down)); % generate the pi down index
index_numeric_down= index_down( 3:end);
mid_row_down= mid_row_pi( index_pi_down);
start_row_down= start_row_pi( index_pi_down);
end_row_down= end_row_pi( index_pi_down);
pi_down{ index_numeric_down( 1)}= DoArithmetic( pi_down( index_numeric_down), mid_row_down( index_numeric_down), ...
    start_row_down( index_numeric_down), end_row_down( index_numeric_down));
pi_down= pi_down(~cellfun(@isempty,pi_down));

inbracket( index_pi_down)={ [] };
inbracket( index_pi_up)={ [] };
inbracket( index_pi)={ [] };
pi_oper= inbracket(~cellfun(@isempty,inbracket));
mid_row_pi= mid_row_pi( ~cellfun(@isempty,inbracket));
start_row_pi= start_row_pi( ~cellfun(@isempty,inbracket));
end_row_pi= end_row_pi( ~cellfun(@isempty,inbracket));
ans_pi=1;   %initialize
issqrt= ( cellfun(@(x) x=='~', pi_oper)==1);
index_para_m= find( ( cellfun(@(x) x=='m', pi_oper) + cellfun(@(x) x=='n', pi_oper))==1);
for m=  pi_down{ end}: pi_up % do pi arithmetic
    
    pi_oper{ index_para_m}= m;
    if sum( issqrt)~=0    %have sqrt
        
        %         temp= pi_oper( issqrt==0);
        %         mid_row=mid_row_pi{ issqrt==0};
        %         start_row= start_row_pi{ issqrt==0};
        %         end_row= end_row_pi{ issqrt==0};
%         ans_pi= sqrt( DoArithmetic( temp, mid_row, start_row, end_row))*ans_pi;
        ans_pi=  DoArithmetic( pi_oper, mid_row_pi, start_row_pi, end_row_pi)*ans_pi;
        
    else
        ans_pi= DoArithmetic( pi_oper, mid_row_pi, start_row_pi, end_row_pi) *ans_pi;
    end
end

end