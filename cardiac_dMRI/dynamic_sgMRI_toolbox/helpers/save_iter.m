% SAVE_ITER updates the variables which store the results of an iteration 
% and saves the results data.
%
% Thomas Sanchez - 2020

error_tot{counter_mask} = average_objective_value;
objective_greedy = [objective_greedy; max_objective];
rate_i_vector = [rate_i_vector; rate_i];
label_selected = [label_selected; selected_index2];
counter_mask = counter_mask +1;
selected_volumes{counter_mask} = samp;

% Regular save of the data at checkpoints
if  (rate_grid_save <= size(rate_grid,2) )
    if ( rate_i > rate_grid(rate_grid_save) ) 
        rate_i_attained = rate_grid(rate_grid_save);
        

        file_name = [results_folder,'/',algo,(sprintf('_rate=%.3f',rate_i_attained)), ...
            '_size=',num2str(nx),'_',num2str(ny),'_',num2str(nt),'_',num2str(ntr), ... 
            '_sampleTr=',sample_selection,'_orientation=',orientation,'_samplingGreedy=',sampling,...
            '_metric=',metric,'_GREEDY.mat'];        
        save(file_name, 'mask','objective_greedy','rate_i_vector','label_selected','rate_i', 'rate_grid_save', 'error_tot', 'selected_volumes');

        rate_grid_save = rate_grid_save +1;         
    end

end

% Save the last iterate
file_name = [results_folder,'/',algo, '_size=',num2str(nx),'_',num2str(ny),'_', ...
    num2str(nt),'_',num2str(ntr),'_sampleTr=', sample_selection, ...
    '_orientation=',orientation,'_samplingGreedy=',sampling, ...
    '_metric=',metric,'_GREEDY.mat'];     
   
    
save(file_name,'mask','objective_greedy','rate_i_vector','label_selected','rate_i', 'selected_volumes')
      

