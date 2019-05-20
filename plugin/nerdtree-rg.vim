if exists('g:nerdtree_rg')
    finish
endif
let g:nerdtree_rg = 1

function! NERDTreeRg()
  let dirnode = g:NERDTreeDirNode.GetSelected()
  echo dirnode.path.str()

  let pattern = input('Enter the search pattern: ')
  if pattern ==# ''
      echo 'Aborted'
      return
  endif

  execute ':NERDTreeClose'

  call fzf#vim#grep(
        \ 'rg --hidden --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case "' . pattern . '" ' . dirnode.path.str(),
        \  1,
        \ fzf#vim#with_preview('right:40%', '?')
        \ )
endfunction

call NERDTreeAddMenuItem({
      \ 'text': '(g)rep directory',
      \ 'shortcut': 'g',
      \ 'callback': 'NERDTreeRg',
      \ })
