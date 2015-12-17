function [bestOpt, bestOdf] = optimalPatternSearch(divider,smallStep)

fhandle =@SeparateOptY;
fileName = strcat('OptimalDividerPatternDat',num2str(divider),'_',num2str(smallStep),'.mat');
%highest = load('Odf.mat')
%odf0 = highest.odfHi;
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

%bigStep = 10;
%smallStep = 1;
allOdfs = [];
allOpts = [];
constraint = [0.0159822999947858,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00818178632407973,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00613766636477021,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00572645585112265,0.00613766636477021,0.00613766636477021,0.00613766636477021,0.00376140480720866,0.00376140480720866,0.00376140480720866,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416700527,0.00454084416700527,0.00454084416782057,0.00454084416782057,0.00541192129558303,0.00495535011431222,0.00495535011431222,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00541192129558303,0.00495535011431222,0.00541192129558303,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777,0.00398197813454777];
idxes =  [32, 70, 64, 76, 21, 19, 3, 2, 15, 12, 36, 43, 20, 13, 42, 63, 44] ;
ub =  [62.56921721693676, 122.22269812362497, 122.22269812362497, 122.22269812362497, 122.22269812362497, 122.22269812362497, 122.22269812362497, 162.92837384252954, 174.6280816613567, 174.6280816613567, 162.92837384252954, 174.6280816613567, 0.1, 174.6280816613567, 162.92837384252954, 174.6280816613567, 174.6280816613567, 174.6280816613567, 174.6280816613567, 174.6280816613567, 162.92837384252954, 174.6280816613567, 162.92837384252954, 174.6280816613567, 174.6280816613567, 174.6280816613567, 174.6280816613567, 174.6280816613567, 162.92837384252954, 162.92837384252954, 162.92837384252954, 265.85811718098495, 265.85811718098495, 265.85811718098495, 220.22336883671596, 220.22336887625664, 220.22336887625664, 220.22336883671596, 220.22336883671596, 220.22336887625664, 220.22336883671596, 220.22336887625664, 220.22336887625664, 220.22336883671596, 220.22336887625664, 220.22336883671596, 220.22336883671596, 220.22336883671596, 220.22336883671596, 220.22336887625664, 220.22336887625664, 220.22336887625664, 220.22336887625664, 220.22336883671596, 220.22336887625664, 220.22336887625664, 220.22336883671596, 220.22336883671596, 184.77726215570718, 201.80208803244076, 201.80208803244076, 184.77726215570718, 201.80208803244076, 184.77726215570718, 184.77726215570718, 184.77726215570718, 184.77726215570718, 184.77726215570718, 201.80208803244076, 184.77726215570718, 251.13146436540367, 251.13146436540367, 251.13146436540367, 251.13146436540367, 251.13146436540367, 251.13146436540367] ;
lb =  [0, 0.14, 0.14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.12, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.11, 0, 0, 0, 0, 0, 0] ;
% upper bound
%for i = 1:76
 %   ub(1,i) = 1/constraint(i);
%end

% starting from each variable (others set to 0)
bestOpt = 9999; % For minimization, we set initial result to be a very high value.
bestOdf = [];
tic
for j = 1: 76 % for each variable
    if ~ismember(j, idxes)
    	continue;
    end
    disp( sprintf( 'Current Variable --------------- %d', j ) );
    clear temp*
    bigStep = ub(j)/divider;
    searchRangeWide = 0:bigStep:ub(j); 
    for i = 1:length(searchRangeWide)
        % starting point: everyone 0 except the variable to be searched
        odf0 = [zeros(1,j-1),searchRangeWide(i),zeros(1,76-j)];
	%odf0  = ',getTopOdfs()[1],';'
 [zeros(1,j-1),searchRangeWide(i),zeros(1,76-j)];
        % search with pattern_search
        [odf,opt] = patternsearch(fhandle,odf0,[],[],constraint,1,lb,ub,@simpleConstraint);
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
        testOdf = [zeros(1,j-1),ub(j),zeros(1,76-j)];
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
	    %smallStep = (searchRangeWide(temp_IndEach+1) - searchRangeWide(temp_IndEach-1))/divider;
            searchRangeNarrow = searchRangeWide(temp_IndEach-1):smallStep:searchRangeWide(temp_IndEach+1);
            for k = 1:length(searchRangeNarrow)   
                odf0 = [zeros(1,j-1),searchRangeNarrow(k),zeros(1,76-j)]; 
                %odf = fmincon('Proper2Opt',odf0,[],[],constraint,1,zeros(1,76),ub);
                [odf,opt] = patternsearch(fhandle,odf0,[],[],constraint,1,lb,ub,@simpleConstraint);
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
        allOdfs = [allOdfs;expOdf];
	allOpts = [allOpts;expOpt];
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
toc
time = toc;
bestOpt = - bestOpt;

save(fileName,'bestOdf','bestOpt','time');

% verify results
for i = 1:size(bestOdf,1)
    fstr = ['outp = ',func2str(fhandle),'(bestOdf(i,:))'];
    eval(fstr);
    if outp ~= -bestOpt
        disp('VERIFICATION - some ODF not right! Check the following');
        disp(i)
    end
end
exit;

