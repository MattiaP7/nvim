Repo creata tramite `NvChad` la mia e' una estensione, aggiunti mappings personalizzati, plugins, formattazione on save, lsp per vari linguaggi. **si presuppone che abbiate gia' esperienza con neovim...**

### pre requisiti
- [nodejs](https://nodejs.org/en)
- [neovim](https://neovim.io/)
- compilatore c++ (clang e gcc... ([mingw](https://winlibs.com/))) nelle variabili d'ambiente
- [ripgrep](https://github.com/BurntSushi/ripgrep) nelle variabili d'ambiente
- [make](https://sourceforge.net/projects/gnuwin32/) nelle variabili d'ambiente

# Installazione


```bash
#powershell
git clone https://github.com/MattiaP7/nvim.git $env:LOCALAPPDATA\nvim

#cmd
git clone https://github.com/MattiaP7/nvim.git cd %LOCALAPPDATA%\nvim
```
eliminare la cartella di `.git`.
In seguito aprire nvim, in automatico dovrebbe partire l'installazione automatica dei pacchetti, dovrebbe partire in automatico l'installazione dei TreeSitter e di Mason, se non dovesse succedere scrivete `MasonInstallAll`. guardate il sito di [NvChad](https://nvchad.com/) per la documentazione ufficiale.

## Risoluzione problemi clang e clangd per windows
Su windows spesso ci sono sempre errori con LSP di clangd, per risolverli, dopo avere installato gcc, installiamo clang, per farlo andiamo su https://github.com/llvm/llvm-project/releases e scegliamo l'installer di windows, come `LLVM-20.1.5-win64.exe` nella installazione ricorda di spuntare **Add LLVM to the system PATH** per verificare la sua installazione nel terminale scriviamo
```bash
clang -v
```
dovrebbe darci la versione per segnalarci che è stato installato correttamente, se però provassi a compilare qualcosa `clang++ a.cpp -o a` avremmo errori che non trova gli header. per sistemare dobbiamo creare un file chiamato `C:\Program Files\LLVM\bin\clang.cfg` qua dentro specifichiamo il target di gcc, per vedere il target scriviamo
```bash
gcc -v

#output
...
Target:  x86_64-w64-mingw32 (ad esempio)
...
```
quindi nel file clang.cfg scriviamo `-target x86_64-w64-mingw32` dopo aver fatto tutto i problemi causati da clang e clangd saranno (teoricamente) risolti.
