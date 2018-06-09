" Vim color file
" Maintainer:   Your name <youremail@something.com>
" Last Change:  
" URL:		

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

" your pick:
set background=dark	" or light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="mycolorscheme"

"hi Normal

" OR

" highlight clear Normal
" set background&
" highlight clear
" if &background == "light"
"   highlight Error ...
"   ...
" else
"   highlight Error ...
"   ...
" endif

" A good way to see what your colorscheme does is to follow this procedure:
" :w 
" :so % 
"
" Then to see what the current setting is use the highlight command.  
" For example,
" 	:hi Cursor
" gives
"	Cursor         xxx guifg=bg guibg=fg 
 	
" Uncomment and complete the commands you want to change from the default.

"hi Cursor		
"hi CursorIM	
"hi Directory	
"hi DiffAdd		
"hi DiffChange	
"hi DiffDelete	
"hi DiffText	
"hi ErrorMsg	
"hi VertSplit	
"hi Folded		
"hi FoldColumn	
"hi IncSearch	
"hi LineNr		
"hi ModeMsg		
"hi MoreMsg		
"hi NonText		
"hi Question	
"hi Search		
"hi SpecialKey	
"hi StatusLine	
"hi StatusLineNC	
"hi Title		
"hi Visual		
"hi VisualNOS	
"hi WarningMsg	
"hi WildMenu	
"hi Menu		
"hi Scrollbar	
"hi Tooltip		

" syntax highlighting groups
"hi Comment
"hi Constant	
"hi Identifier	
"hi Statement	
"hi PreProc	
"hi Type		
"hi Special	
"hi Underlined	
"hi Ignore		
"hi Error		
"hi Todo		

" for good colormap see
" http://www.calmar.ws/vim/color-output.png

"hi Folded cterm=bold ctermbg=230 ctermfg=232
hi clear Folded
hi Folded cterm=bold ctermbg=235 ctermfg=196
hi FoldColumn cterm=bold ctermbg=255 ctermfg=196
" headers
hi org_heading1 cterm=bold ctermbg=252 ctermfg=235
hi org_heading2 cterm=bold ctermbg=246 ctermfg=234
hi org_heading3 cterm=bold ctermbg=240 ctermfg=235
hi org_heading4 cterm=bold ctermbg=White ctermfg=Cyan
hi org_heading5 cterm=bold ctermbg=White ctermfg=Cyan
hi org_heading6 cterm=bold ctermbg=White ctermfg=Cyan
hi org_heading7 cterm=bold ctermbg=White ctermfg=Cyan
" stars in front of headlines
hi org_shade_stars ctermfg=196
" timestamps
hi org_timestamp cterm=bold ctermbg=38 ctermfg=232
hi org_timestamp_inactive cterm=bold ctermbg=142 ctermfg=232
" todo and done
hi org_todo_keyword_TODO ctermbg=196 ctermfg=226
hi org_todo_keyword_DONE ctermbg=46 ctermfg=232
" lists
hi org_list_def cterm=bold ctermfg=47
hi org_list_ordered cterm=bold ctermfg=47
hi org_list_unordered cterm=bold ctermfg=47
hi org_list_unordered_2nd_level cterm=bold ctermfg=26

"org_deadline_scheduled
" hyperlinks
hi hyperlink cterm=underline ctermfg=26
hi link hyperlinkURL hyperlink
hi hyperlinkBracketsLeft ctermfg=50
hi hyperlinkBracketsRight ctermfg=50
"" table
"org_table_separator
"org_table_horizontal_line
"org_table
"org_comment
hi org_bold cterm=bold 
hi org_italic cterm=italic
hi org_underline cterm=underline
"org_code
"org_verbatim
"org_block_delimiter
"org_key_identifier
"org_title
"org_properties_delimiter
"org_property
"org_property_value

