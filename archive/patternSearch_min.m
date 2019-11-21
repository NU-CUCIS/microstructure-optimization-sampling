function [bestOpt, bestOdf] = patternSearch_min(fhandle)

%This function calls global optimization tool patternsearch to perform optimization
%   Since the pattern search algorithm requires a starting point (odf0), in
%   this program we enumerate different starting points incrementally,
%   firstly with a relatively wide interval (10). After the initial best
%   starting point is found, additional searches are done by refining the
%   interval to a smaller value (1).
%   Note that the starting point does NOT have to meet the constraint.
%
%The function patternsearch initially deals with minimization, in order to
%   transform it into maximization, firstly the fhandle gives the negative
%   of what we really want, and secondly, we change it back after obtaining
%   it.

%INPUT: 
% fhandle: function handle of the function to be minimized
%   for example, patternSearch_min(@materialOpt)

%OUTPUTS:
% bestOpt: the maximum property obtained 
% bestOdf: the ODF ( or ODFs if size(bestOdf,1)>1 ) that leads to maximal
%   property


clc
warning off

bigStep = 10;
smallStep = 1;

constraint = [0.0159822999947858,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00613766636477021,0.00613766636477021,0.00376140480720866,0.00376140480720866,0.00376140480720866,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00541192129558303,0.00495535011431222,0.00495535011431222,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777];

% upper bound
for i = 1:76
    ub(1,i) = 1/constraint(i);
end

% starting from each variable (others set to 0)
bestOpt = 9999; % For minimization, we set initial result to be a very high value.
bestOdf = [];

for j = 1: 76 % for each variable
    disp( sprintf( 'Current Varialbe --------------- %d', j ) );
    clear temp*
    searchRangeWide = 0:bigStep:1/constraint(j); 
    for i = 1:length(searchRangeWide)
        % starting point: everyone 0 except the variable to be searched
        odf0 = [zeros(1,j-1),searchRangeWide(i),zeros(1,76-j)];
        % search with pattern_search
        [odf,opt] = patternsearch(fhandle,odf0,[],[],constraint,1,zeros(1,76),ub);
        %odf = fmincon('Proper2Opt',odf0,[],[],constraint,1,zeros(1,76),ub);
        % save the best objective found
        fstr = ['tempOpt(i) = ',func2str(fhandle),'(odf);'];
        eval(fstr);
        % save the best solution found
        tempOdf(i,:) = odf;
    end
    
    tempInd = find(tempOpt == min(tempOpt)); % the best among all starting points
    
    % handle multiple bests
        
    %if length(tempInd) > 1
    %    tempInd = tempInd(1);
    %end
    
    if ismember(1,tempInd) % one of the best is at the beginning
        expOpt = min(tempOpt);
        expOdf = tempOdf(tempInd,:);
        
    elseif ismember(length(searchRangeWide),tempInd) % one of the best is at the end
        % test the real end
        testOdf = [zeros(1,j-1),1/constraint(j),zeros(1,76-j)];
        fstr = ['testOpt = ',func2str(fhandle),'(testOdf);'];
        eval(fstr);
        if testOpt < min(tempOpt)
            expOpt = testOpt;
            expOdf = testOdf;
        else
            expOpt = min(tempOpt);
            expOdf = tempOdf(tempInd,:);
        end
    else
        test2Opt = [];
        test2Odf = [];
        for rs_iter = 1: length(tempInd)
            clear temp_indEach searchRangeNarrow
            temp_IndEach = tempInd(rs_iter);
            % re-search
            searchRangeNarrow = searchRangeWide(temp_IndEach-1):smallStep:searchRangeWide(temp_IndEach+1);
            for k = 1:length(searchRangeNarrow)   
                odf0 = [zeros(1,j-1),searchRangeNarrow(k),zeros(1,76-j)]; 
                %odf = fmincon('Proper2Opt',odf0,[],[],constraint,1,zeros(1,76),ub);
                [odf,opt] = patternsearch(fhandle,odf0,[],[],constraint,1,zeros(1,76),ub);
                % [odf,opt] = patternsearch(@Proper2Opt,odf0,[],[],constraint,1,zeros(1,76),ub);
                fstr = ['temp2Opt(k) = ',func2str(fhandle),'(odf);'];
                eval(fstr);
                temp2Odf(k,:) = odf;
            end
            test2Opt = [test2Opt,min(temp2Opt)];
            test2Odf = [test2Odf;temp2Odf(find(temp2Opt == min(temp2Opt)),:)];
        end
        
        testOpt = min(test2Opt);
        testOdf = test2Odf(find(test2Opt == min(test2Opt)),:);
        
        if testOpt < min(tempOpt)
            expOpt = testOpt;
            expOdf = testOdf;
        else
            expOpt = min(tempOpt);
            expOdf = tempOdf(tempInd,:);
        end
        
        if expOpt < bestOpt
            bestOpt = expOpt;
            bestOdf = expOdf;
        elseif expOpt == bestOpt
            bestOdf = [bestOdf;expOdf];
        end
    end
        
%         tmin = find(tempOpt == min(tempOpt));
%         if length(tmin) > 1
%             for k = 1:length(tmin)
%                 bestOdf = [bestOdf;tempOdf(tmin(k),:);];
%             end
%         else
%             bestOdf = [bestOdf;tempOdf(tmin,:);];
%         end
      
end

% verify results
for i = 1:size(bestODF,1)
    fstr = ['outp = ',func2str(fhandle),'(bestODF(i,:))'];
    eval(fstr);
    if outp ~= bestOPT
        disp('VERIFICATION - some ODF not right! Check the following');
        disp(i)
    end
end

bestOPT = - bestOPT;

save('./proper1Opt_PatternSearch.mat','bestODF','bestOPT');


