% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
% % % % % % Change the scaling of exsiting figure % % % % % % % % % % %
% % % % % % % % % % % % % % Study PPO % % %  % % % % % %  % % % % %
% % % % % % % % % % % % Dr Sussman's lab % % % % % % % % % % % % % % %
% % % % % % % % % Albert Einstein College of Medicine % % % % % % % % %
% % % % % % Last updated on 9/8/2017 by Huizhen Tang (Joann) % % % % % %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%% clear workspace
clear
%% Specify all the figures need to be scaled.
[fname,pathname] = uigetfile(...
    { '*.fig*','Select figure or figures';'*.fig','All figures' }, ...
    'Select figure or figures', ...
    'Multiselect','on');
% Abort if the user hit 'Cancel'
if isequal(fname,0)||isequal(pathname,0),disp('Aborted.'); return; end
%% Open figures
if iscell(fname)== 0;
    fig = openfig(fname)
    %redefine scaling
    prompt = {'Y asix scaling (needs to be even # larger than 0)'};
    dlg_title = 'Waveform properties';
    num_lines = 1;
    defAns = {'10'};
    answer = inputdlg(prompt,dlg_title,num_lines,defAns);%%% If the user clicks the Cancel button to close an input dialog box,
    % Abort if the user clicks 'Cancel'.
    if isempty(answer), disp('Aborted.');
        return;
    end
    [yscale status] = str2num(answer{1});
    if ~status  %%%Handle empty value returned for unsuccessful conversion
        msgbox('Invalid Number','Error in Parameter settings','error');
    end
    nyscale = -yscale;
    for i = 1:2
        ax = subplot(1,2,i)
        set(ax,'ylim',[nyscale yscale],'ytick',nyscale:yscale/2:yscale)
    end
    saveas(fig,([fname(1:end-4) '.png']));
    saveas(fig,([fname(1:end-4) '.fig']));
elseif iscell(fname) == 1;
    for i = 1:length(fname)
        fig = openfig(fname{i})
    %redefine scaling
    prompt = {'Y asix scaling (needs to be even # larger than 0)'};
    dlg_title = 'Waveform properties';
    num_lines = 1;
    defAns = {'10'};
    answer = inputdlg(prompt,dlg_title,num_lines,defAns);%%% If the user clicks the Cancel button to close an input dialog box,
    % Abort if the user clicks 'Cancel'.
    if isempty(answer), disp('Aborted.');
        return;
    end
    [yscale status] = str2num(answer{1});
    if ~status  %%%Handle empty value returned for unsuccessful conversion
        msgbox('Invalid Number','Error in Parameter settings','error');
    end
    nyscale = -yscale;
    for i = 1:2
        ax = subplot(1,2,i)
        set(ax,'ylim',[nyscale yscale],'ytick',nyscale:yscale/2:yscale)
    end
    saveas(fig,([fname{i}(1:end-4) '.png']));
    saveas(fig,([fname{i}(1:end-4) '.fig']));
    end
end