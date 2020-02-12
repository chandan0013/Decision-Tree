function [Train_x1,Train_y1,Train_x2,Train_y2,row,col] = CPTS570HW2Q2_1(X,Y,Z,T) 
   Train_x = X;
   Train_y = Y;
   [r,~] = size(Train_x);
   Feature_sort = Z;
   Entropy = zeros(9,9);
   count1 = sum(Train_y == 2);
   for i = 2:10 
        for ii = 1:length(Feature_sort)-1
            threshold = Feature_sort(ii) + ((Feature_sort(ii+1)- Feature_sort(ii))/2);
            j = sum(Train_x(:,i) < threshold);
            count = 0;
            for k = 1:r
                if (Train_x(k,i) < threshold)
                    if(Train_y(k,1) == 2)
                       count = count +1;
                    end
                end
            end   
            p = count/j;
            E1 = - p*log(p) - (1-p)*log(1-p);
            E2 = - ((count1-count)/r-j)*log(((count1-count)/r-j)) - (1-((count1-count)/(r-j)))*log((1-((count1-count)/(r-j))));
            Entropy(i-1,ii) = (j/r)*E1 + (1-(j/r))*E2;
        end
   end
   [~, index] = min(Entropy(:));
   [row, col] = ind2sub(size(Entropy), index);
   % feature_row# and T(col) is the threshold
   r1 = sum(Train_x(:,row+1) < T(col));
   Train_x1 = zeros(r1,10);
   Train_y1 = zeros(r1,1);
   Train_x2 = zeros(r-r1,10);
   Train_y2 = zeros(r-r1,1);
   index = 0;
   index1 = 0;
   for i = 1:r
      if(Train_x(i,row+1) < T(col))
         index = index +1;
         Train_x1(index,:)  = Train_x(i,:);
         Train_y1(index,:) = Train_y(i,:);
      else
         index1 = index1 +1;
         Train_x2(index1,:)  = Train_x(i,:);
         Train_y2(index1,:) = Train_y(i,:);
      end
   end
end