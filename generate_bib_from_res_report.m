input_file = 'report.xlsx';
output_file = 'refs.txt';

converter_script_command = 'curl -LH "Accept: text/x-bibliography; style=apa" https://doi.org/';

T = readtable(input_file);

for d=1:numel(T.DOI)
    
    doi = T.DOI{d};
%     disp([converter_script_command,doi]);
    
    [stat,cmdout] = system([converter_script_command,doi]);%;,'-echo');
  
    clean_string_list = {'*.','β.','1.'};
    
    % clean the entries from above
    
    c0 = strtrim(cmdout);
    for c=1:numel(clean_string_list)
        
        c1 = split(c0,clean_string_list{c});
        for i=1:numel(c1)
            c1(i) = strtrim(c1(i));
        end
        c0 = strjoin(c1);
        
    end
    
    refs{d} = c0;
    disp(refs{d});
    
end

Tout = table(refs');

writetable(Tout,output_file,'WriteVariableNames',false,'QuoteStrings',false);

disp('DONE');