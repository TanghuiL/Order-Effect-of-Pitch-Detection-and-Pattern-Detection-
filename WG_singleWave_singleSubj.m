% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % For plotting MMN waveforms % % % % % % % % % % %
% % % % % % % % % % % % % % Study PPO % % %  % % % % % %  % % % % %
% % % % % % % % % % % % Dr Sussman's lab % % % % % % % % % % % % % % %
% % % % % % % % % Albert Einstein College of Medicine % % % % % % % % %
% % % % % % Last updated on 9/27/2017 by Huizhen Tang (Joann) % % % % % %
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
% select waveform
[fname,pathname] = uigetfile(...
    { '*.dat*','Select ERP waveform';'*.dat','All dat Files' }, ...
    'Select the first waveform', ...
    'Multiselect','on');
% Abort if the user hit 'Cancel'
if isequal(fname,0)||isequal(pathname,0),disp('Aborted.'); return; end
%% Load and Read waveform
figure
%% specify the scaling for y axis
prompt = {'Y asix min','Y asix max'};
dlg_title = 'Y scaling';
num_lines = 1;
defAns = {'-5','5'};
answer = inputdlg(prompt,dlg_title,num_lines,defAns);%%% If the user clicks the Cancel button to close an input dialog box,
% Abort if the user clicks 'Cancel'.
if isempty(answer), disp('Aborted.');
    return;
end
[nyscale status] = str2num(answer{1});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end
[yscale status] = str2num(answer{2});
if ~status  %%%Handle empty value returned for unsuccessful conversion
    msgbox('Invalid Number','Error in Parameter settings','error');
end

for sj=1:length(fname)
ffile = fullfile(pathname,fname{sj});
fprintf(1,'Processing %s\n',ffile);
[fid,msg] = fopen(ffile, 'rt'); %%% get file indentifier. Here 'r' sets the permission, which is the type of access of the file, read, write, append, or update. attching a 't' specifies whether to open files in binary or text mode.
if fid == -1,
    fprintf(1,'Error opening dat file "%s":', ffile);
    disp(msg);
    return;
end
% identifier "fid" into a cell array
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
%% waveform plotting
subplot(ceil(length(fname)/2),2,sj)
ts = stt:1000/ft:endt;
xl = length(ts); %x axis length
ch = [2 3 4]; 
h = {};
rgb1 = [0 0 255;255 0 255;0 255 0;0 0 0]; rgb1 = rgb1/255;
for i = 1:length(ch)
    plot(ts,wave1(1:xl,ch(i)),'-','color',rgb1(i,:),'LineWidth',4)
    hold on
end

if length(ch) == 1
    lgd = legend(chls{ch(1)},'Location','NorthEastOutside');
elseif length(ch) == 2
    lgd = legend(chls{ch(1)},chls{ch(2)},'Location','NorthEastOutside');
elseif length(ch) == 3
    lgd = legend(chls{ch(1)},chls{ch(2)},chls{ch(3)},'Location','NorthEastOutside');
end
lgd.Orientation = 'vertical'; lgd.Box = 'off'; lgd.FontSize = 30;

xlim([-100 500]); xticks([-100 0 100 200 300 400 500])
ylim([nyscale yscale]); 
if abs(nyscale)>= yscale*2
yticks(nyscale:yscale:yscale)
elseif abs(nyscale)>= yscale && abs(nyscale)<yscale*2
yticks(nyscale:yscale/2:yscale)
elseif yscale > 2*abs(nyscale)
    yticks(nyscale:abs(nyscale):yscale)
elseif yscale > abs(nyscale) && yscale < 2*abs(nyscale)
    yticks(nyscale:abs(nyscale)/2:yscale)
else
end
grid on
set(gca,'fontsize',30,'fontname','Times New Roman')
ylabel('µV','fontsize',30,'fontname','Times New Roman');
title(fname{sj}(12:17))
xlabel('Time (ms)','fontsize',30,'fontname','Times New Roman');
hold off
end 
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 24 24];
saveas(fig,(['Obli-' fname{1}(6:10) fname{1}(18:end-4) '.png']));
saveas(fig,(['Obli-' fname{1}(6:10) fname{1}(18:end-4) '.fig']));
%% code ends here

