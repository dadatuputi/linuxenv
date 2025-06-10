## [Install Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)
Requirements: `tmux` version 1.9 (or higher), `git`, `bash`.

Clone TPM:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Clone .tmux.conf
```
wget https://raw.githubusercontent.com/dadatuputi/linuxenv/main/.tmux.conf -O ~/.tmux.conf
```

## Refresh tmux environment
```
tmux source ~/.tmux.conf 
<prefix> + I
```

## Update plugins
```
<prefix> + U
```
