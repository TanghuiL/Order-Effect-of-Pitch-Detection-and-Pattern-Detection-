% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % For plotting MMN waveforms % % % % % % % % % % %
% % % % % % % % % % % % % % Study PPO % % %  % % % % % %  % % % % %
% % % % % % % % % % % % Dr Sussman's lab % % % % % % % % % % % % % % %
% % % % % % % % % Albert Einstein College of Medicine % % % % % % % % %
% % % % % % Last updated on 9/8/2017 by Huizhen Tang (Joann) % % % % % %
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
stopper = 1; 
while stopper > 0
% select the 1st waveform
[fname1,pathname1] = uigetfile(...
    { '*.dat*','Select ERP waveform';'*.dat','All dat Files' }, ...
    'Select the first waveform', ...
    'Multiselect','off');
% Abort if the user hit 'Cancel'
if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
% select the 2nd waveform
[fname2,pathname2] = uigetfile(...
    { '*.dat*','Select ERP waveform';'*.dat','All dat Files' }, ...
    'Select the waveform to subtract', ...
    'Multiselect','off');
% Abort if the user hit 'Cancel'
if isequal(fname2,0)||isequal(pathname2,0),disp('Aborted.'); return; end
% select the difference wave
[fname3,pathname3] = uigetfile(...
    { '*.dat*','Select difference waveform';'*.dat','All dat Files' }, ...
    'Select the differene wave', ...
    'Multiselect','off');
% Abort if the user hit 'Cancel'
if isequal(fname3,0)||isequal(pathname3,0),disp('Aborted.'); return; end
%% Load and Read the 1st waveform
ffile = fullfile(pathname1,fname1);
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
k = 0; wave_dt = []; data1 = data{1}(50:end);
for j = 1:length(data1)
    dt = str2num(data1{j});
    if ~isempty(dt), k=k+1; wave_dt(k) = dt; end
end
n_row = length(wave_dt)/length(chls); %length(chls) is the total number of channels.
for n = 1:n_row,
    D = wave_dt(((n-1)*length(chls)+1):n*length(chls));
    wave1(n,:) = D;
end
%% Load and Read the 2nd waveform
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
k = 0; wave_dt = []; data1 = data{1}(50:end);
for j = 1:length(data1)
    dt = str2num(data1{j});
    if ~isempty(dt), k=k+1; wave_dt(k) = dt; end
end
n_row = length(wave_dt)/length(chls); %length(chls) is the total number of channels.
for n = 1:n_row,
    D = wave_dt(((n-1)*length(chls)+1):n*length(chls));
    wave2(n,:) = D;
end
% load difference waveform 
% wave_dif = wave1-wave2;
%% Load and Read the 2nd waveform
ffile = fullfile(pathname3,fname3);
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
k = 0; wave_dt = []; data1 = data{1}(50:end);
for j = 1:length(data1)
    dt = str2num(data1{j});
    if ~isempty(dt), k=k+1; wave_dt(k) = dt; end
end
n_row = length(wave_dt)/length(chls); %length(chls) is the total number of channels.
for n = 1:n_row,
    D = wave_dt(((n-1)*length(chls)+1):n*length(chls));
    wave3(n,:) = D;
end
wave_dif = wave3;

%% waveform plotting
%% specify the scaling for y axis
prompt = {'Y asix scaling (needs to be even # larger than 0)'};
dlg_title = 'Waveform properties';
num_lines = 1;
defAns = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,defAns);%%% If the user clicks the Cancel button to close an input dialog box,
% % % Abort if the user clicks 'Cancel'.
if isempty(answer), disp('Aborted.');
    return;
end
[yscale status] = str2num(answer{1});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
nyscale = -yscale;
% 
ts = stt:1000/ft:endt;
xl = length(ts); %x axis length
figure
subplot(1,2,1)
ch1 = [2 3 4]; h = {};
rgb1 = [0 0 255;255 0 255;0 255 0;0 0 0]; rgb1 = rgb1/255;
for i = 1:length(ch1)
    plot(ts,wave1(1:xl,ch1(i)),'-','color',rgb1(i,:),'LineWidth',4)
    hold on
end
lgd = legend(chls{ch1(1)},chls{ch1(2)},chls{ch1(3)},'Location','NorthEastOutside');
lgd.Orientation = 'vertical'; lgd.Box = 'off'; lgd.FontSize = 24;
for i = 1:length(ch1)
    plot(ts,wave2(1:xl,ch1(i)),'--','color',rgb1(i,:),'LineWidth',4)
end
xlim([-100 500]); xticks([-100 0 100 200 300 400 500])
ylim([nyscale yscale]); yticks(nyscale:yscale/2:yscale)
grid on
set(gca,'fontsize',24,'fontname','Times New Roman')
ylabel('µV','fontsize',24,'fontname','Times New Roman');
title('ERPs')
xlabel('Time (ms)','fontsize',24,'fontname','Times New Roman');
hold off

subplot(1,2,2)
ch2 = [2 30];
rgb2 = [0 0 0;0.7 0.7 0.7];
plot(ts,wave_dif(1:xl,ch2(1)),'-','color',rgb2(1,:),'LineWidth',4)
hold on
plot(ts,wave_dif(1:xl,ch2(2)),'-','color',rgb2(2,:),'LineWidth',2)
xlim([-100 500]); xticks([-100 0 100 200 300 400 500])
ylim([nyscale yscale]); yticks(nyscale:yscale/2:yscale)
grid on
set(gca,'fontsize',24,'fontname','Times New Roman')
ylabel('µV','fontsize',24,'fontname','Times New Roman');
title('Diff')
xlabel('Time (ms)','fontsize',24,'fontname','Times New Roman');
lgd = legend(chls{ch2(1)},chls{ch2(2)},'Location','NorthEastOutside');
lgd.Orientation = 'vertical'; lgd.Box = 'off'; lgd.FontSize = 24;
hold off

fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 24 6];
saveas(fig,(['MMN-' fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '.png']));
saveas(fig,(['MMN-' fname1(6:(end-4)) '-vs-' fname2(6:(end-4)) '.fig']));
%% Decide whether continue to do a new pair of comparison
prompt = {'Continue importing waves? (1= YES; 0=NO)'};
dlg_title = 'wave importing';
num_lines = 1;
defAns = {'1'};
answer = inputdlg(prompt,dlg_title,num_lines,defAns);
%Abort if the user clicks 'cancel'
if isempty(answer),disp('Aborted');return;end
[stopper status] = str2num(answer{1});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
end
%% code ends here

