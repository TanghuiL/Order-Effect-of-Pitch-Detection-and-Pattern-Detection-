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
prompt = {'Please indicate the total number of waveforms',...
    'Epoch starts at (e.g. -100 ms)',...
    'Epoch ends at (e.g. 800 ms)' };
dlg_title = 'Waveform properties';
num_lines = 1;
defAns = {'4','-100','800'};
answer = inputdlg(prompt,dlg_title,num_lines,defAns);%%% If the user clicks the Cancel button to close an input dialog box,
% % % Abort if the user clicks 'Cancel'.
if isempty(answer), disp('Aborted.');
    return;
end
[num status] = str2num(answer{1});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
[stt status] = str2num(answer{2});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
[endt status] = str2num(answer{3});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
%% Get ERP waveforms
if num == 2,
    % select the 1st waveform
    [fname1,pathname1] = uigetfile(...
        { '*.dat*','Select the first ERP waveform';'*.*','All Files' }, ...
        'Select .dat file(s)', ...
        'Multiselect','off');
    % Abort if the user hit 'Cancel'
    if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
    % select the 2nd waveform
    [fname2,pathname2] = uigetfile(...
        { '*.dat*','Select the second ERP waveform';'*.*','All Files' }, ...
        'Select .dat file(s)', ...
        'Multiselect','off');
    % Abort if the user hit 'Cancel'
    if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
    pathname{1} = pathname1; pathname{2} = pathname2;
    fname{1} = fname1; fname{2} = fname2;
elseif num == 3,
    % select the 1st waveform
    [fname1,pathname1] = uigetfile(...
        { '*.dat*','Select the first ERP waveform';'*.*','All Files' }, ...
        'Select .dat file(s)', ...
        'Multiselect','off');
    if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
    % select the 2nd waveform
    [fname2,pathname2] = uigetfile(...
        { '*.dat*','Select the second ERP waveform';'*.*','All Files' }, ...
        'Select .dat file(s)', ...
        'Multiselect','off');
    if isequal(fname2,0)||isequal(pathname2,0),disp('Aborted.'); return; end
    % select the 3rd waveform
    [fname3,pathname3] = uigetfile(...
        { '*.dat*','Select the second ERP waveform';'*.*','All Files' }, ...
        'Select .dat file(s)', ...
        'Multiselect','off');
    if isequal(fname3,0)||isequal(pathname3,0),disp('Aborted.'); return; end
    pathname{1} = pathname1; pathname{2} = pathname2; pathname{3} = pathname3;
    fname{1} = fname1; fname{2} = fname2;fname{3} = fname3;
elseif num == 4
    % select the 1st waveform
    [fname1,pathname1] = uigetfile(...
        { '*.dat*','Select the first ERP waveform';'*.*','All Files' }, ...
        'Select .dat file(s)', ...
        'Multiselect','off');
    if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
    % select the 2nd waveform
    [fname2,pathname2] = uigetfile(...
        { '*.dat*','Select the second ERP waveform';'*.*','All Files' }, ...
        'Select .dat file(s)', ...
        'Multiselect','off');
    if isequal(fname2,0)||isequal(pathname2,0),disp('Aborted.'); return; end
    % select the 3rd waveform
    [fname3,pathname3] = uigetfile(...
        { '*.dat*','Select the second ERP waveform';'*.*','All Files' }, ...
        'Select .dat file(s)', ...
        'Multiselect','off');
    if isequal(fname3,0)||isequal(pathname3,0),disp('Aborted.'); return; end
    [fname4,pathname4] = uigetfile(...
        { '*.dat*','Select the second ERP waveform';'*.*','All Files' }, ...
        'Select .dat file(s)', ...
        'Multiselect','off');
    if isequal(fname4,0)||isequal(pathname4,0),disp('Aborted.'); return; end
    pathname{1} = pathname1; pathname{2} = pathname2;
    pathname{3} = pathname3;pathname{4} = pathname4;
    fname{1} = fname1; fname{2} = fname2;fname{3} = fname3;fname{4} = fname4;
else disp('Too many waveforms (maximum is 4)')
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
    k = 0; wave_dt = []; data1 = data{1}(210:end);
    for j = 1:length(data1)
        dt = str2num(data1{j});
        if ~isempty(dt), k=k+1; wave_dt(k) = dt; end
    end
    n_row = length(wave_dt)./32; %32 is the total number of channels.
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
t = stt:2:endt;
if num == 2
    for ch = 5
        figure
        plot(t,wave(1,:,ch),'-m','LineWidth',4)
        hold on
        plot(t,wave(2,:,ch),'b','LineWidth',4)
        title(chls{ch})
        xlabel('Time (ms)');
        ylabel('Amplitude (µV)');
        legend([fname1(1:4),'-',fname1(6:(end-4))],[fname2(1:4),'-',fname2(6:(end-4))],'Location','northeast')
        hold off
        saveas (gcf,([fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '-' chls{ch} '.pdf']));
        saveas (gcf,([fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '-' chls{ch} '.fig']));
    end
elseif num == 3
    for ch = 5
        figure
        plot(t,wave(1,:,ch),'-m','LineWidth',4)
        hold on
        plot(t,wave(2,:,ch),'b','LineWidth',4)
        plot(t,wave(3,:,ch),'k','LineWidth',4)
        title(chls{ch})
        xlabel('Time (ms)');
        ylabel('Amplitude (µV)');
        legend([fname1(1:4),'-',fname1(6:(end-4))],[fname2(1:4),'-',fname2(6:(end-4))],[fname3(1:4),'-',fname3(6:(end-4))],'Location','northeast')
        hold off
        saveas (gcf,([fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '-vs-' fname3(6:(end-4)) '-' chls{ch} '.pdf']));
        saveas (gcf,([fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '-vs-' fname3(6:(end-4)) '-' chls{ch} '.fig']));
    end
elseif num == 4
    for ch = 5
        figure
        plot(t,wave(1,:,ch),'-m','LineWidth',4)
        hold on
        plot(t,wave(2,:,ch),'b','LineWidth',4)
        plot(t,wave(3,:,ch),'k','LineWidth',4)
        plot(t,wave(4,:,ch),'g','LineWidth',4)
        title(chls{ch})
        xlabel('Time (ms)');
        ylabel('Amplitude (µV)');
        legend([fname1(1:4),'-',fname1(6:(end-4))],[fname2(1:4),'-',fname2(6:(end-4))],[fname3(1:4),'-',fname3(6:(end-4))],[fname4(1:4),'-',fname4(6:(end-4))],'Location','northeast')
        hold off
        saveas (gcf,([fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '-vs-' fname3(6:(end-4)) '-vs-' fname4(6:(end-4)) '-' chls{ch} '.pdf']));
        saveas (gcf,([fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '-vs-' fname3(6:(end-4)) '-vs-' fname4(6:(end-4)) '-' chls{ch} '.fig']));
    end
else
end




