[num txt]=xlsread('CDWtoIDWTransitionX-Y','A1:C3600');
I=find(isnan(num(:,1)));
for i=1:length(I)
   if(i==1)
      data{i} = num(1:I(i)-1,:); 
   else
       data{i} = num(I(i-1)+1:I(i)-1,:); 
   end
end
data{i+1}=num(I(i)+1:end,:);

