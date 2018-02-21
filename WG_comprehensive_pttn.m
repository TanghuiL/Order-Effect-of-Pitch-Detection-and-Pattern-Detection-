% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % % % % % % % For ploting ERP waveforms % % % % % % % % % % %
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
prompt = {'Epoch starts at (e.g. -100 ms)','Epoch ends at (e.g. 500 ms)',...
    'Sampling rate (e.g. 500 Hz)',...
    'How many waves in comparison? (e.g. 2 = 2 way comparison)'};
dlg_title = 'Waveform properties';
num_lines = 1;
defAns = {'-200','2340','500','2'};
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
if cmp_n == 1,
    while stopper > 0
        % select the 1st waveform
        [fname1,pathname1] = uigetfile(...
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
        k = k + 1;
        fname{k*cmp_n} = fname1; pathname{k*cmp_n} = pathname1;
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
elseif cmp_n == 2,
    while stopper > 0
        % select the 1st waveform
        [fname1,pathname1] = uigetfile(...
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
        % select the 2nd waveform
        [fname2,pathname2] = uigetfile(...
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
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
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
        % select the 2nd waveform
        [fname2,pathname2] = uigetfile(...
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname2,0)||isequal(pathname2,0),disp('Aborted.'); return; end
        [fname3,pathname3] = uigetfile(...
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
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
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname1,0)||isequal(pathname1,0),disp('Aborted.'); return; end
        % select the 2nd waveform
        [fname2,pathname2] = uigetfile(...
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname2,0)||isequal(pathname2,0),disp('Aborted.'); return; end
        [fname3,pathname3] = uigetfile(...
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
            'Select .dat file(s)', ...
            'Multiselect','off');
        % Abort if the user hit 'Cancel'
        if isequal(fname3,0)||isequal(pathname3,0),disp('Aborted.'); return; end
        [fname4,pathname4] = uigetfile(...
            { '*.dat*','Select ERP waveform';'*.*','All Files' }, ...
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
    n_row = length(wave_dt)/length(chls); %length(chls) is the total number of channels.
    for n = 1:n_row,
        D = wave_dt(((n-1)*length(chls)+1):n*length(chls));
        wave(i,n,:) = D;
    end
end

%% plot the waveforms of all electrodes
ch = 2; % only plot Oz
ts = stt:1000/ft:endt; xl = length(ts);
figure
for n = 1:(length(fname)/cmp_n)
    subplot(length(fname)/cmp_n,1,n)
    if cmp_n == 1
        plot(ts,wave(n*cmp_n,1:xl,ch),'color',[0,0.7,1],'LineWidth',1)
        xlim([-220 2360]); ylim([-10 10])
        lgd = legend(fname{n*cmp_n}(6:(end-4)),'Location','NorthEast')
        lgd.Orientation = 'horizontal'; lgd.Box = 'off'; lgd.FontSize = 8;
        xticks([]); yticks([]);
    elseif cmp_n == 2
        plot(ts,wave(n*cmp_n-1,1:xl,ch),'color',[0,0.7,1],'LineWidth',2)
        hold on
        plot(ts,wave(n*cmp_n,1:xl,ch),'color',[1,0,1],'LineWidth',2)
        xlim([-220 2360]); ylim([-10 15])
        %         lgd = legend(fname{n*cmp_n-1}(6:(end-4)), fname{n*cmp_n}(6:(end-4)),'Location','SouthEast')
        lgd = legend(fname{n*cmp_n-1}(10:(end-4)), fname{n*cmp_n}(10:(end-4)),'Location','SouthEast')
        lgd.Orientation = 'horizontal'; lgd.Box = 'off';lgd.FontSize = 24;
        xticks([0 410 820 1230 1640])
        grid on
        set(gca,'fontsize',24,'fontname','Times New Roman')
        ylabel('µV','fontsize',24,'fontname','Times New Roman');
    elseif cmp_n == 3
        plot(ts,wave(n*cmp_n-2,1:xl,ch),'color',[0,0,0],'LineWidth',2)
        hold on
        plot(ts,wave(n*cmp_n-1,1:xl,ch),'color',[1,0,1],'LineWidth',2)
        plot(ts,wave(n*cmp_n,1:xl,ch),'color',[0,0.7,1],'LineWidth',2)
        xlim([-220 2360]); ylim([-10 10])
        lgd = legend(fname{n*cmp_n-2}(6:(end-4)), fname{n*cmp_n-1}(6:(end-4)),fname{n*cmp_n}(6:(end-4)),'Location','SouthEast');
        lgd.Orientation = 'horizontal'; lgd.Box = 'off'; lgd.FontSize = 24;
        xticks([0 410 820 1230 1640])
        grid on
        set(gca,'fontsize',24,'fontname','Times New Roman')
        ylabel('µV','fontsize',24,'fontname','Times New Roman');
    elseif cmp_n == 4
        plot(ts,wave(n*cmp_n-3,1:xl,ch),'color',[0,0,0],'LineWidth',4)
        hold on
        plot(ts,wave(n*cmp_n-2,1:xl,ch),'color',[1,0,1],'LineWidth',4)
        plot(ts,wave(n*cmp_n-1,1:xl,ch),'color',[0,0.7,1],'LineWidth',4)
        plot(ts,wave(n*cmp_n,1:xl,ch),'color',[0,1,0],'LineWidth',4)
        xlim([-220 2360]); ylim([-30 30])
        lgd = legend('XXXO','XXXXO','XTXO','XXTO','Location','NorthEast')
        lgd.Orientation = 'horizontal'; lgd.Box = 'off';lgd.FontSize = 36;
        xticks([0 410 820 1230 1640 2050])
        grid on
        set(gca,'fontsize',36,'fontname','Times New Roman')
        ylabel('µV','fontsize',36,'fontname','Times New Roman');
    else
    end
    %     if n == 1, title(['Electrode-' chls{ch}],'fontsize',14), end
    if cmp_n == 1 && n == (length(fname)/cmp_n),xticks([0 410 820 1230 1640]),
        yticks([-10 10]),
        ylabel('µV','fontsize',24,'fontname','Times New Roman'),
    end
end
xlabel('Time (ms)','fontsize',24,'fontname','Times New Roman');
hold off
fig = gcf;
fig.PaperUnits = 'inches';
fig.PaperPosition = [0 0 24 24];
if cmp_n == 1
    saveas (gcf,([fname{n*cmp_n}(6:(end-4)) '-' chls{ch} '.png']));
    saveas (gcf,([fname{n*cmp_n}(6:(end-4)) '-' chls{ch} '.fig']));
elseif cmp_n == 2
    saveas (gcf,(['std--vs--dev-' chls{ch} '.png']));
    saveas (gcf,(['std--vs--dev-' chls{ch} '.fig']));
    %     saveas (gcf,([fname{n*cmp_n-1}(6:(end-4)) '-vs-' fname{n*cmp_n}(6:(end-4)) '-' chls{ch} '.png']));
    %     saveas (gcf,([fname{n*cmp_n-1}(6:(end-4)) '-vs-' fname{n*cmp_n}(6:(end-4)) '-' chls{ch} '.fig']));
elseif cmp_n == 3
    saveas (gcf,([fname{n*cmp_n-2}(6:(end-4)) '-vs-' fname{n*cmp_n-1}(6:(end-4)) '-vs-' fname{n*cmp_n}(6:(end-4)) '-' chls{ch} '.png']));
    saveas (gcf,([fname{n*cmp_n-2}(6:(end-4)) '-vs-' fname{n*cmp_n-1}(6:(end-4)) '-vs-' fname{n*cmp_n}(6:(end-4)) '-' chls{ch} '.fig']));
elseif cmp_n == 4
    saveas (gcf,([fname{n*cmp_n-3}(6:(end-4)) '-vs-' fname{n*cmp_n-2}(6:(end-4)) '-vs-' fname{n*cmp_n-1}(6:(end-4)) '-vs-' fname{n*cmp_n}(6:(end-4)) '-' chls{ch} '.png']));
    saveas (gcf,([fname{n*cmp_n-3}(6:(end-4)) '-vs-' fname{n*cmp_n-2}(6:(end-4)) '-vs-' fname{n*cmp_n-1}(6:(end-4)) '-vs-' fname{n*cmp_n}(6:(end-4)) '-' chls{ch} '.fig']));
else
end

%% code ends here


%% figure
% for n = 1:(length(fname)/cmp_n)
%     plot(ts,wave(n,1:xl,ch),'color',[1-0.04*n,0,1-0.04*n],'LineWidth',1)
%     xlim([-220 3020]); ylim([-10 15])
% %     lgd = legend(fname{n*cmp_n}(6:(end-4)),'Location','NorthEast')
% %     lgd.Box = 'off'; lgd.FontSize = 8;
%     xticks([0 550 1100 1650 2200 2750])
%     grid on
%     set(gca,'fontsize',14,'fontname','Times New Roman')
%     title(['Electrode-' chls{ch}],'fontsize',14)
%     hold on
% end
%     Legend.Box = 'off'
%     xticks([0 550 1100 1650 2200 2750])
%     grid on
%     set(gca,'fontsize',24,'fontname','Times New Roman')
%     title(['Electrode-' chls{ch}],'fontsize',24)
% ylabel('µV','fontsize',24,'fontname','Times New Roman'),
% xlabel('Time (ms)','fontsize',24,'fontname','Times New Roman');
% hold off
%

%
% for n = 1:(length(fname)/cmp_n)
%     figure(n)
%     plot(ts,wave(n,1:xl,ch),'color',[1,0,1],'LineWidth',2)
%     xlim([-220 3020]); ylim([-10 15])
%     lgd = legend(fname{n}(6:(end-4)),'Location','NorthEast')
%     lgd.Box = 'off'; lgd.FontSize = 14;
%     xticks([0 550 1100 1650 2200 2750])
%     grid on
%     set(gca,'fontsize',24,'fontname','Times New Roman')
%     if n == 1, title(['Electrode-' chls{ch}],'fontsize',24), end
%     ylabel('µV','fontsize',24,'fontname','Times New Roman'),
%     xlabel('Time (ms)','fontsize',24,'fontname','Times New Roman');
%     saveas (gcf,([fname{n}(6:(end-4)) '-' chls{ch} '.png']));
%     saveas (gcf,([fname{n}(6:(end-4)) '-' chls{ch} '.fig']));
% end



