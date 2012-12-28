"===========================================================================
"  vimrc by pachicoma
"  LastUpdate: 2012.12.09 19:41 
"===========================================================================
set nocompatible     " Vi互換モードは利用しない

"############################################################
" KaoriYa設定
"############################################################
" autofmt: 日本語文章のフォーマット(折り返し)プラグイン.
set formatexpr=autofmt#japanese#formatexpr()


"############################################################
" 基本的なVim設定
"############################################################
" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!
	autocmd FileType text setlocal textwidth=80
	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	" Also don't do it when the mark is in the first line, that is the default
	" position when opening a file.
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   exe "normal! g`\"" |
				\ endif
augroup END

"############################################################
" 環境に関する設定
"############################################################
"--------------------------------------------------
" 設定ファイル
"--------------------------------------------------
" パス指定
let MYVIMRC=$HOME+'/_vimrc'

" vimrcの編集/更新
nnoremap <silent> <Space>eg :<C-u>tabnew $MYVIMRC<CR>
nnoremap <silent> <Space>rg :<C-u>source $MYVIMRC<CR>

"--------------------------------------------------
" ヘルプに関する設定
"--------------------------------------------------
set helplang=ja      " 表示ヘルプ言語

" help ショートカット
"nnoremap <C-h> :<C-u>help<Space> 

" q でヘルプウィンドウを閉じる
autocmd FileType help nnoremap <buffer> q <C-w>c

"--------------------------------------------------
" 警告に関する設定
"--------------------------------------------------
"set debug=throw
set novb             " ビープ音,フラッシュ無効
set t_vb=            " ビープ音,フラッシュ無効

"--------------------------------------------------
" カラースキーム/フォント設定
"--------------------------------------------------
if has("gui_running")
	syntax on
	colorscheme wombat
	set hlsearch
	if has('win32')
		set guifont=Inconsolata:h10.5:cSHIFTJIS
	else
		set guifont=Monospace\ 9
		set guifontwide=Monospace\ 9
	endif
elseif &t_Co > 2 
	syntax on
	set hlsearch
	colorscheme wombat_cui
endif

"--------------------------------------------------
" 日本語入力設定
"--------------------------------------------------
set iminsert=0		" 挿入モードでIMEをONしない 2で前回のIME状態を復元とのことだが動作しない
set imsearch=-1		" 検索時のIME状態はiminsertに依存

if has('multi_byte_ime')
  " IMEの状態によってカーソルカラーを変更
  highlight Cursor guifg=NONE guibg=Gray
  highlight CursorIM guifg=NONE guibg=Purple

  " ノーマルモードではIME無効にする
  inoremap <ESC> <ESC>:set iminsert=0<CR>	
endif

" 日本語入力固定モード
inoremap <silent> <C-j> <C-^>
"inoremap <silent> <ESC> <ESC>
"inoremap <silent> <C-[> <ESC>

"--------------------------------------------------
" セッション関連
"--------------------------------------------------
" セッションで保存する内容
set sessionoptions=buffers,folds,resize,sesdir,winpos,winsize


"--------------------------------------------------
" バッファ
"--------------------------------------------------
" ディレクトリの自動移動
au BufEnter * execute ":lcd %:p:h"

" ファイルエンコーディング設定
set fileencodings=iso-2022-jp-3,iso-2022-jp,euc-jisx0213,utf-8,ucs-bom,euc-jp,eucjp-ms,cp932
set encoding=cp932

" 保存設定
set nobackup         " バックアップファイルは作らない
set history=100      " コマンド履歴の制限数
set undolevels=50    " undoの制限数

" Ctrl+Sで保存
noremap <C-s> <Esc>:<C-u>w<CR>	

" バッファの移動
map <silent> <C-down> :bn<CR>
map <silent> <C-up> :bp<CR>
nmap <silent> <Space>bb :ls<CR>:buf

"--------------------------------------------------
" ウィンドウ
"--------------------------------------------------
set splitbelow       " ウィンドウを上下に分割するとき、新しいウィンドウは下に作る
set splitright       " ウィンドウを左右に分割するとき、新しいウィンドウは右に作る 
"map <silent> <F8> :SM4<CR>
"map <silent> <S-F8> :SM0<CR>

"--------------------------------------------------
" タブ
"--------------------------------------------------
map <silent> <C-t>o :tabnew<CR>
map <silent> <C-t>q :tabclose<CR>
map <silent> <C-h> :tabprevious<CR>
map <silent> <C-l> :tabnext<CR>

"--------------------------------------------------
" QuickFix
"--------------------------------------------------
nmap <silent> <Leader>qf :cwindow<CR>
nmap <silent> <Leader>qc :cclose<CR>


"############################################################
" 基本的なエディタに関する設定
"############################################################
"--------------------------------------------------
" メニューの表示をキーでトグル
"--------------------------------------------------
map <silent> <Space><C-m> :if &guioptions =~# 'T' <Bar>
			\set guioptions-=T <Bar>
			\set guioptions-=m <Bar>
			\else <Bar>
			\set guioptions+=T <Bar>
			\set guioptions+=m <Bar>
			\endif<CR>

"--------------------------------------------------
" 基本的な表示設定
"--------------------------------------------------
set number             " 行番号表示
set ruler              " カーソル位置などを右下に表示
set cursorline         " カーソル行に下線を表示
set cmdheight=1        " コマンドラインの高さ
set showbreak=>\       " 折り返し行の先頭に表示する文字列
set ambiwidth=double   " ■とかを正しく表示 
"set foldmethod=indent  " インデントで折畳む

" タブ/インデントについて
set tabstop=4        " 画面上でのタブが占める幅
set softtabstop=4    " TabやBS押下時のカーソル移動値
set shiftwidth=4     " autoindentや<<,>>でのインデント量
set shiftround       " インデント量をshiftwidthの倍数で丸める
set formatoptions=q  " 自動フォーマット

" ウィンドウ幅で折り返しON/OFF切替
nnoremap <silent> <Space>ow :<C-u>setlocal wrap!<CR>

"--------------------------------------------------
" ステータスラインに表示する情報の設定
"--------------------------------------------------
"[BuffNo][読専][Help][Preview] FilePath[修正F] >> (行,列)[utf-8:unix][最終行]
set statusline=[%n]%r%h%w%F\ %m%=(%l,%c)\ [%{&fenc!=''?&fenc:&enc}:%{&ff}][%LL]
set laststatus=2     " ステータスラインを常時表示
let g:hi_insert = 'hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow cterm=none'


set showcmd          " 未完了コマンドをステータスラインに表示

"--------------------------------------------------
" コマンドライン 
"--------------------------------------------------
set wildmenu               " コマンドライン補完拡張モード
set wildmode=longest:full  " コマンドライン補完で、共通部分最長補完＋wildmenu

" ;でコマンド入力モードへ
noremap ; :

"--------------------------------------------------
" カーソル移動
"--------------------------------------------------
set backspace=indent,eol,start
nnoremap <C-j> 3j
nnoremap <C-k> 3k
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
set whichwrap=b,s,h,l,<,>,[,]



"############################################################
" 検索・ジャンプ
"############################################################
"--------------------------------------------------
" 検索
"--------------------------------------------------
set incsearch        " インクリメンタル検索 
set gdefault         " 検索時は/gオプション付がデフォルト
set ignorecase       " 大文字・小文字区別無しで検索
set smartcase        " 検索パターンが大文字を含んでいたら区別する
if has("migemo")
	set migemo
endif

" ハイライト表示を解除する
nmap <silent><ESC><ESC> :noh<CR>

"--------------------------------------------------
" 置換
"--------------------------------------------------
" ビジュアルモードで選択中の文字を置換対象にする(副作用で選択中の文字をヤンク)
vnoremap <C-x>r y:<C-u>%s/<C-R>"//gc<Left><Left><Left>
" カーソル位置の単語を置換対象にする(副作用でカーソル位置の単語をヤンク)
nnoremap <C-x>r yiw:<C-u>%s/<C-R>"//gc<Left><Left><Left>

"--------------------------------------------------
" Grep
"--------------------------------------------------
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nH    " grepコマンドの指定

" grep検索後QuickFixを開く
augroup grepopen
	autocmd!
	autocmd QuickfixCmdPost vimgrep cw
augroup END

" ビジュアルモードで選択中の文字をgrep対象にする(副作用で選択中の文字をヤンク)
vnoremap <C-x>g y:<C-u>vimgrep /<C-R>"/
" カーソル位置の単語をgrep対象にする(副作用でカーソル位置の単語をヤンク)
nnoremap <C-x>g yiw:<C-u>vimgrep /<C-R>"/

"--------------------------------------------------
" Tags
"--------------------------------------------------
" tagsファイルパス指定
"set tags=./tags,./*/tags,../tags,../*/tags,../../tags,../../../tags
"if has('path_extra')
	set tag+=**;$HOME
"endif

" タグジャンプキーバインド

"nnoremap t <Nop>
"nnoremap tj <C-]>
"nnoremap tg :<C-u>tag<CR>
"nnoremap tt :<C-u>pop<CR>
"nnoremap tl :<C-u>tags<CR>


" テンプレートファイルの指定
augroup templateload
	autocmd!
	autocmd BufNewFile *.py 0r $VIMRUNTIME/templates/skelton.py
augroup END


"--------------------------------------------------
" その他の設定
"--------------------------------------------------
"set complete=".,w,b,u,t,i"

" Visual,Insertモードでマウスを使用可能に
if has('mouse')
	set mouse=a
endif
set clipboard=unnamed,autoselect  " ビジュアルモードのヤンクなどで無名レジスタを使用する
set guioptions+=a

" カーソル位置の単語をヤンクで置換え
nnoremap <silent> cy ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

"インデント
vnoremap < <gv
vnoremap > >gv

"set makeprg=C:/ein/installs/MinGW/bin/mingw32-make.exe
"set runtimepath+=C:/ein/installs/MinGW/bin


" ----------------------------------------
" 入力補完単語候補
" ----------------------------------------
iabbr iday <C-r>=strftime("%Y.%m.%d")<CR>
iabbr inow <C-r>=strftime("%Y.%m.%d %H:%M")<CR>


"############################################################
" Plugins
"############################################################
filetype off

"--------------------------------------------------
" neobundle
"--------------------------------------------------
if has('vim_starting')
  set runtimepath+=~/vimfiles/.bundle/neobundle.vim/
  call neobundle#rc(expand('~/vimfiles/.bundle'))
endif

"NeoBundle 'git://github.com/Shougo/clang_complete.git'
"NeoBundle 'git://github.com/Shougo/echodoc.git'
"NeoBundle 'git://github.com/Shougo/unite.vim.git'
"NeoBundle 'git://github.com/Shougo/vim-vcs.git'
"NeoBundle 'git://github.com/Shougo/vimshell.git'
"NeoBundle 'git://github.com/Shougo/vinarise.git'
"Git Hub
NeoBundle 'vim-jp/vimdoc-ja.git'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neobundle.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'fuenor/qfixhowm'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'nathanaelkane/vim-indent-guides'

NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'ShowMarks'
NeoBundle 'vim-scripts/marks_corey.vim'

" No Repository
"NeoBundle 'ShowMarks', {'type' : 'nosync', 'base' : '~/vimfiles/.bundle/.bundle_manual'}

"--------------------------------------------------
" qfixhowm
"--------------------------------------------------
let howm_dir          = '~/howm_dir/'
let howm_fileencoding = 'cp932'
let howm_fileformat   = 'dos'


"--------------------------------------------------
" YankRing
"--------------------------------------------------
let g:yankring_history_dir = expand('$HOME')
let g:yankring_history_file = '.yankring_history'
let g:yankring_max_history = 10
let g:yankring_window_height = 13
nnoremap <silent> <Leader>rs :YRShow<CR>


"--------------------------------------------------
" ShowMarks
"--------------------------------------------------
let g:showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
nnoremap <silent>m,t :ShowMarksToggle<CR>


"--------------------------------------------------
" indent-guides
"--------------------------------------------------
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1


"EOF ########################################################
filetype plugin indent on

