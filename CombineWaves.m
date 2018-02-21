% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % For combine two waveforms % % % % % % % % % % %
% % % % % % % % % % % % % % Study PPO % % %  % % % % % %  % % % % %
% % % % % % % % % % % % Dr Sussman's lab % % % % % % % % % % % % % % %
% % % % % % % % % Albert Einstein College of Medicine % % % % % % % % %
% % % % Last updated on 9/5/2017 by Huizhen Tang (Joann) % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%% clear workspace
clear
%% defining electrodes
chls = {'FPz', 'Fz', 'Cz', 'Pz', 'Oz', 'FP1', 'FP2', 'F7', 'F8', 'PO9', ...
    'PO10', 'FC5', 'FC6', 'FC1', 'FC2', 'T7', 'T8', 'C3', 'C4', 'CP5', ...
    'CP6', 'CP1', 'CP2', 'P7', 'P8', 'P3', 'P4', 'O1', 'O2', 'LM', 'RM', 'EOG' };
%% specify the number of waveforms
prompt = {'Epoch starts at (e.g. -200 ms)','Epoch ends at (e.g. 2340 ms)',...
    'Sampling rate (e.g. 500 Hz)'};
dlg_title = 'Waveform properties';
num_lines = 1;
defAns = {'-100','500','500'};
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
%% Get ERP waveforms
% select the 1st waveform
[fname11,pathname11] = uigetfile(...
    { '*.dat*','Select ERP waveform';'*.dat','All dat Files' }, ...
    'Select the first waveform to combine', ...
    'Multiselect','off');
% Abort if the user hit 'Cancel'
if isequal(fname11,0)||isequal(pathname11,0),disp('Aborted.'); return; end
% select the 2nd waveform
[fname12,pathname12] = uigetfile(...
    { '*.dat*','Select ERP waveform';'*.dat','All dat Files' }, ...
    'Select the 2nd waveform to combine', ...
    'Multiselect','off');
% Abort if the user hit 'Cancel'
if isequal(fname12,0)||isequal(pathname12,0),disp('Aborted.'); return; end
% select the waveform to subtract
[fname2,pathname2] = uigetfile(...
    { '*.dat*','Select ERP waveform';'*.dat','All dat Files' }, ...
    'Select the waveform to subtract', ...
    'Multiselect','off');
% Abort if the user hit 'Cancel'
if isequal(fname2,0)||isequal(pathname2,0),disp('Aborted.'); return; end
%% Load and Read the 1st waveform
ffile = fullfile(pathname11,fname11);
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
n_row = length(wave_dt)/length(chls); %length(chls) is the total number of channels.
for n = 1:n_row,
    D = wave_dt(((n-1)*length(chls)+1):n*length(chls));
    wave11(n,:) = D;
end

%% Load and Read the 2nd waveform
ffile = fullfile(pathname12,fname12);
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
n_row = length(wave_dt)/length(chls); %length(chls) is the total number of channels.
for n = 1:n_row,
    D = wave_dt(((n-1)*length(chls)+1):n*length(chls));
    wave12(n,:) = D;
end

wave1 = wave11 + wave12;

%% Load and Read the waveform to subtract
ffile = fullfile(pathname2,fname2);
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
n_row = length(wave_dt)/length(chls); %length(chls) is the total number of channels.
for n = 1:n_row,
    D = wave_dt(((n-1)*length(chls)+1):n*length(chls));
    wave2(n,:) = D;
end

wave_dif = wave1 - wave2;


%% plot the waveforms, including the 1st, the 2nd, and the difference waveforms.
ch = [1 2 3 4 30]; % only plot Oz
ts = stt:1000/ft:endt; xl = length(ts);
   figure
for i = 1:length(ch)
     subplot(length(ch),1,i)
    plot(ts,wave1(1:xl,ch(i)),'color',[0,0.7,1],'LineWidth',4)
    hold on
    plot(ts,wave2(1:xl,ch(i)),'color',[0,0,0],'LineWidth',4)
    plot(ts,wave_dif(1:xl,ch(i)),'color',[0,0,0],'LineWidth',1)
    %         xlim([-220 2340]);
    xlim([-100 500])
    ylim([-30 30])
    yticks([-20 -10 0 10 20])
    grid on
    set(gca,'fontsize',24,'fontname','Times New Roman')
    ylabel('µV','fontsize',24,'fontname','Times New Roman');
    if i == 1
        lgd = legend('T','X','diff','Location','NorthEast');
        %          lgd = legend(fname1(6:(end-4)), fname2(6:(end-4)),'diff','Location','SouthEast');
        lgd.Orientation = 'horizontal'; lgd.Box = 'off'; lgd.FontSize = 24;
    else
    end
    title([chls{ch(i)}])
end

%         xticks([0 410 820 1230 1640])
% xticks([0 100 200 300 400])
xlabel('Time (ms)','fontsize',24,'fontname','Times New Roman');
hold off
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 12 24];
% saveas (gcf,([fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '-' chls{ch} '.png']));
% saveas (gcf,([fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '-' chls{ch} '.fig']));
saveas (gcf,([fname11(6:(end-4)) '-vs-' fname2(6:(end-4)) '.png']));
saveas (gcf,([fname11(6:(end-4)) '-vs-' fname2(6:(end-4)) '.fig']));
%% code ends here

