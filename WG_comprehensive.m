% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % For ploting ERP waveforms % % % % % % % % % % %
% % % % % % % % % % % % % % VisA study 2 % % %  % % % % % %  % % % % %
% % % % % % % % % % % % Dr Sussman's lab % % % % % % % % % % % % % % %
% % % % % % % % % Albert Einstein College of Medicine % % % % % % % % %
% % % % Last updated on 4/5/2017 by Huizhen Tang (Joann) % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%% clear workspace
clear

%% specify the number of waveforms
prompt = {'Epoch starts at (e.g. -100 ms)','Epoch ends at (e.g. 800 ms)',...
    'Sampling rate (e.g. 500 Hz)',...
    'How many waves in comparison? (e.g. 2 = 2 way comparison)'};
dlg_title = 'Waveform properties';
num_lines = 1;
defAns = {'-100','800','500','2'};
answer = inputdlg(prompt,dlg_title,num_lines,defAns);%%% If the user clicks the Cancel button to close an input dialog box,
% % % Abort if the user clicks 'Cancel'.
if isempty(answer), disp('Aborted.');
    return;
end
[stt status] = str2num(answer{1});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
[endt status] = str2num(answer{2});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
[ft status] = str2num(answer{3});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
[cmp_n status] = str2num(answer{4});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
%% Get ERP waveforms
stopper = 1; k = 0;
if cmp_n == 2,
    while stopper > 0
        % select the 1st waveform
        [fname1,pathname1] = uigetfile(...
            { '*.dat*','Select the first ERP waveform of subject 1';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
        % select the 2nd waveform
        [fname2,pathname2] = uigetfile(...
            { '*.dat*','Select the second ERP waveform of subject 1';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname2,0)||isequal(pathname2,0),disp('Aborted.'); return; end
        k = k+1;
        fname{k*cmp_n-1} = fname1; fname{k*cmp_n} = fname2;
        pathname{k*cmp_n-1} = pathname1; pathname{k*cmp_n} = pathname2;
        
        %Terminator-whether continue importing waveforms
        prompt = {'Continue importing waves? (1=YES;0=NO)'};
        dlg_title = 'wave importing';
        num_lines = 1;
        defAns = {'1'};
        answer = inputdlg(prompt,dlg_title,num_lines,defAns);%%% If the user clicks the Cancel button to close an input dialog box,
        %Abort if the user clicks 'Cancel'
        if isempty(answer), disp('Aborted.');
            return;
        end
        [stopper status] = str2num(answer{1});
        if ~status  %%%Handle empty value returned for unsuccessful conversion
            msgbox('Invalid Number','Error in Parameter settings','error');
        end
    end
elseif cmp_n == 3
    while stopper > 0
        % select the 1st waveform
        [fname1,pathname1] = uigetfile(...
            { '*.dat*','Select the first ERP waveform of subject 1';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
        % select the 2nd waveform
        [fname2,pathname2] = uigetfile(...
            { '*.dat*','Select the second ERP waveform of subject 1';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname2,0)||isequal(pathname2,0),disp('Aborted.'); return; end
        [fname3,pathname3] = uigetfile(...
            { '*.dat*','Select the second ERP waveform of subject 1';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname3,0)||isequal(pathname3,0),disp('Aborted.'); return; end
        
        k = k+1;
        fname{k*cmp_n-2} = fname1; fname{k*cmp_n-1} = fname2; fname{k*cmp_n} = fname3;
        pathname{k*cmp_n-2} = pathname1; pathname{k*cmp_n-1} = pathname2; pathname{k*cmp_n} = pathname3;
        
        %Terminator-whether continue importing waveforms
        prompt = {'Continue importing waves? (1=YES;0=NO)'};
        dlg_title = 'wave importing';
        num_lines = 1;
        defAns = {'1'};
        answer = inputdlg(prompt,dlg_title,num_lines,defAns);%%% If the user clicks the Cancel button to close an input dialog box,
        %Abort if the user clicks 'Cancel'
        if isempty(answer), disp('Aborted.');
            return;
        end
        [stopper status] = str2num(answer{1});
        if ~status  %%%Handle empty value returned for unsuccessful conversion
            msgbox('Invalid Number','Error in Parameter settings','error');
        end
    end
    
elseif cmp_n == 4
    while stopper > 0
        % select the 1st waveform
        [fname1,pathname1] = uigetfile(...
            { '*.dat*','Select the first ERP waveform of subject 1';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
        % select the 2nd waveform
        [fname2,pathname2] = uigetfile(...
            { '*.dat*','Select the second ERP waveform of subject 1';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname2,0)||isequal(pathname2,0),disp('Aborted.'); return; end
        [fname3,pathname3] = uigetfile(...
            { '*.dat*','Select the second ERP waveform of subject 1';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname3,0)||isequal(pathname3,0),disp('Aborted.'); return; end
        [fname4,pathname4] = uigetfile(...
            { '*.dat*','Select the second ERP waveform of subject 1';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname4,0)||isequal(pathname4,0),disp('Aborted.'); return; end
        
        k = k+1;
        fname{k*cmp_n-3} = fname1; fname{k*cmp_n-2} = fname2; fname{k*cmp_n-1} = fname3; fname{k*cmp_n} = fname4;
        pathname{k*cmp_n-3} = pathname1; pathname{k*cmp_n-2} = pathname2; pathname{k*cmp_n-1} = pathname3; pathname{k*cmp_n} = pathname4;
        
        %Terminator-whether continue importing waveforms
        prompt = {'Continue importing waves? (1=YES;0=NO)'};
        dlg_title = 'wave importing';
        num_lines = 1;
        defAns = {'1'};
        answer = inputdlg(prompt,dlg_title,num_lines,defAns);%%% If the user clicks the Cancel button to close an input dialog box,
        %Abort if the user clicks 'Cancel'
        if isempty(answer), disp('Aborted.');
            return;
        end
        [stopper status] = str2num(answer{1});
        if ~status  %%%Handle empty value returned for unsuccessful conversion
            msgbox('Invalid Number','Error in Parameter settings','error');
        end
    end
end

%% Load and Read waveforms
for i = 1: length(fname)
    ffile = fullfile(pathname{i},fname{i});
    fprintf(1,'Processing %s\n',ffile);
    [fid,msg] = fopen(ffile, 'rt'); %%% get file indentifier. Here 'r' sets the permission, which is the type of access of the file, read, write, append, or update. attching a 't' specifies whether to open files in binary or text mode.
    if fid == -1,
        fprintf(1,'Error opening dat file "%s":', ffile);
        disp(msg);
        return;
    end
    % identifier "fid" into a cell array.
    data = textscan(fid, '%s'); %%% Before reading a file with textscan, you must open the file with the fopen function. fopen supplies the fid input required by textscan. When you are finished reading from the file, close the file by calling fclose(fid).
    fclose(fid);
    %% reshape vector format data to a matrix
    k = 0; wave_dt = []; data1 = data{1}(220:end);
    for j = 1:length(data1)
        dt = str2num(data1{j});
        if ~isempty(dt), k=k+1; wave_dt(k) = dt; end
    end
    n_row = length(wave_dt)/32; %32 is the total number of channels.
    for n = 1:n_row,
        D = wave_dt(((n-1)*32+1):n*32);
        wave(i,n,:) = D;
    end
end
%% defining electrodes
chls = {'FPz', 'Fz', 'Cz', 'Pz', 'Oz', 'FP1', 'FP2', 'F7', 'F8', 'PO9', ...
    'PO10', 'FC5', 'FC6', 'FC1', 'FC2', 'T7', 'T8', 'C3', 'C4', 'CP5', ...
    'CP6', 'CP1', 'CP2', 'P7', 'P8', 'P3', 'P4', 'O1', 'O2', 'LM', 'RM', 'EOG' };
%% plot the waveforms of all electrodes
ch = 5; % only plot Oz
ts = stt:1000/ft:endt;
figure
for n = 1:(length(fname)/cmp_n)
    subplot(length(fname)/cmp_n,1,n)
    if cmp_n == 2
        plot(ts,wave(n*2-1,:,ch),'-m','LineWidth',4)
        hold on
        plot(ts,wave(n*2,:,ch),'b','LineWidth',4)
        xlim([-120 820]); ylim([-10 10])
        legend(fname{n*2-1}(6:(end-4)), fname{n*2}(6:(end-4)),'Location','NorthEastOutside')
    elseif cmp_n == 3
        plot(ts,wave(n*3-2,:,ch),'-m','LineWidth',4)
        hold on
        plot(ts,wave(n*3-1,:,ch),'b','LineWidth',2)
        plot(ts,wave(n*3,:,ch),'k','LineWidth',4)
        xlim([-120 820]); ylim([-10 10])
        legend(fname{n*3-2}(6:(end-4)), fname{n*3-1}(6:(end-4)),fname{n*3}(6:(end-4)),'Location','NorthEastOutside')
    elseif cmp_n == 4
        plot(ts,wave(n*4-3,:,ch),'-m','LineWidth',2)
        hold on
        plot(ts,wave(n*4-2,:,ch),'b','LineWidth',2)
        plot(ts,wave(n*4-1,:,ch),'k','LineWidth',2)
        plot(ts,wave(n*4,:,ch),'-g','LineWidth',2)
        xlim([-120 820]); ylim([-10 10])
        legend(fname{n*4-3}(6:(end-4)), fname{n*4-2}(6:(end-4)),fname{n*4-1}(6:(end-4)),fname{n*4}(6:(end-4)),'Location','NorthEastOutside')
    else
    end
    if n == 1, title(['Electrode-' chls{ch}],'fontsize',14), end
    ylabel('µV','fontsize',14,'fontname','Times New Roman');
    
end
xlabel('Time (ms)','fontsize',14,'fontname','Times New Roman');
hold off
if cmp_n == 2
    saveas (gcf,([fname{n*2-1}(6:(end-4)) '-vs-' fname{n*2}(6:(end-4)) '-' chls{ch} '.pdf']));
    saveas (gcf,([fname{n*2-1}(6:(end-4)) '-vs-' fname{n*2}(6:(end-4)) '-' chls{ch} '.fig']));
elseif cmp_n == 3
    saveas (gcf,([fname{n*3-2}(6:(end-4)) '-vs-' fname{n*3-1}(6:(end-4)) '-vs-' fname{n*3}(6:(end-4)) '-' chls{ch} '.pdf']));
    saveas (gcf,([fname{n*3-2}(6:(end-4)) '-vs-' fname{n*3-1}(6:(end-4)) '-vs-' fname{n*3}(6:(end-4)) '-' chls{ch} '.fig']));
elseif cmp_n == 4
    saveas (gcf,([fname{n*4-3}(6:(end-4)) '-vs-' fname{n*4-2}(6:(end-4)) '-vs-' fname{n*4-1}(6:(end-4)) '-vs-' fname{n*4}(6:(end-4)) '-' chls{ch} '.pdf']));
    saveas (gcf,([fname{n*4-3}(6:(end-4)) '-vs-' fname{n*4-2}(6:(end-4)) '-vs-' fname{n*4-1}(6:(end-4)) '-vs-' fname{n*4}(6:(end-4)) '-' chls{ch} '.fig']));
else
end
