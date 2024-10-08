{ pkgs, lib, config, username, ... }:
{
  home.shellAliases = {
    "..." = "cd ../..";
    # TODO why does this not work? Reboot to double check
    cfN = "${pkgs.nvim}/bin/nvim ~/nixfiles/hosts/default/configuration.nix"; 
  };
  programs = {
    nushell = { 
      enable = true;

        ##################################################
        #################### Aliases #####################
        ##################################################

      shellAliases = {
        cat = "bat";
        # cpt = "rsync -rtDvzP --update ~/share/Teaching/* /run/media/${username}/Teaching/";
        cpt = "rsync -auhPK --update ~/share/Teaching/*  /run/media/${username}/Teaching/";
        e = "emacsclient";
        g = "git";
        ka = "killall";
        sxiv = "nsxiv";
        trem = "transmission-remote";
        sdn = "shutdown -h now";
        z = "zathura";
        copy = "xsel --clipboard";
        copyp = "xsel --primary";
        lf = "^lf";
        weath = "less -S ~/.cache/weatherreport";
        vim = "nvim";
        v = "nvim";
        vpn = "Outline-Client.AppImage --disable-gpu";

        ##################################################
        #################### Directories #################
        ##################################################
        b = "cd ~/Documents/Business";
        c = "cd ~/Documents/Business/Consulting";
        cac = "cd ~/.cache";
        cf = "cd ~/.config";
        cfs = "cd ~/.config/nvim/mysnips";
        cl = "cd ~/Documents/Business/Clients/";
        d = "cd ~/Documents";
        D = "cd ~/Downloads";
        ltk = "cd ~/Documents/Business/Law-to-Know";
        m = "cd ~/Music";
        pa = "cd ~/Pictures/Arden";
        pp = "cd ~/Pictures";
        rr = "cd ~/.local/src";
        six = "cd ~/share/Teaching/reveal.js-master/6G";
        span = "cd ~/share/Teaching/reveal.js-master/Spanish/";
        sev = "cd ~/share/Teaching/reveal.js-master/7G";
        sc = "cd ~/.local/bin";
        src = "cd ~/.local/src";
        te = "cd ~/Documents/Business/Templates";
        kehua = "cd ~/share/Teaching/reveal.js-master/";
        games = "cd ~/share/Teaching/reveal.js-master/Games";
        ti = "cd ~/texmf/tex/latex/local";
        vv = "cd ~/Videos";
        ww = "cd ~/.var/app/com.tencent.WeChat/xwechat_files/wxid_l0zluz5mpig922_e8d6/msg";

        ##################################################
        #################### Config Files ################
        ##################################################
        cfb = "nvim ~/nixfiles/modules/home-manager/browsers.nix";
        cfn = "nvim ~/nixfiles/modules/home-manager/nushell.nix";
        cfN = "nvim ~/nixfiles/hosts/default/configuration.nix";
        cfh = "nvim ~/nixfiles/hosts/default/home.nix";
        cfH = "nvim ~/nixfiles/modules/home-manager/hyprland.nix";
        cfhk = "nvim ~/nixfiles/modules/home-manager/hyprland-keybindings.nix";
        cfk = "nvim ~/nixfiles/modules/home-manager/kitty.nix";
        cfl = "nvim ~/nixfiles/modules/home-manager/lf.nix";
        cfm = "nvim ~/.config/mutt/muttrc		# mutt (email client) config";
        cfM = "nvim ~/.config/mpv/mpv.conf		# mutt (email client) config";
        cfma = "nvim ~/nixfiles/modules/home-manager/mako.nix";
        cfq = "nvim ~/.config/qutebrowser/config.py	# sxiv (image viewer) key/script handler";
        cfu = "nvim ~/.config/newsboat/urls		# RSS urls for newsboat";
        cfv = "nvim ~/nixfiles/modules/home-manager/nixvim/default.nix";
        cfw = "nvim ~/nixfiles/modules/home-manager/waybar.nix";
      };

      environmentVariables = {
        PATH = "($env.PATH | split row (char esep) | prepend /home/myuser/.apps | append /usr/bin/env)";
      };

      extraConfig = with config.colorScheme.palette; ''

      $env.config = {
        show_banner: false 

        ls: {
          use_ls_colors: true 
          clickable_links: true 
        }

        rm: {
          always_trash: true 
        }

        table: {
          mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
          index_mode: always 
          show_empty: true 
          padding: { left: 1, right: 1 } 
          trim: {
            methodology: wrapping 
            wrapping_try_keep_words: true 
            truncating_suffix: "..." 
          }

          header_on_separator: false 
                  # abbreviated_row_count: 10 # limit data rows from top and bottom after reaching a set point
          }

          error_style: "fancy" 

          datetime_format: {
            # normal: '%a, %d %b %Y %H:%M:%S %z'    # shows up in displays of variables or other datetime's outside of tables
            # table: '%m/%d/%y %I:%M:%S%p'          # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
          }

          explore: {
            status_bar_background: {fg: "#${base01}", bg: "#${base04}"},
            command_bar_text: {fg: "#${base03}"},
            highlight: {fg: "#${base00}", bg: "#${base0A}"},
            status: {
              error: {fg: "#${base06}", bg: "#${base08}"},
              warn: {}
              info: {}
            },
            table: {
              split_line: {fg: "#${base03}"},
              selected_cell: {bg: "#${base0D}"},
              selected_row: {},
              selected_column: {},
            },
          }

          history: {
            max_size: 100_000 
            sync_on_enter: true 
            file_format: "plaintext" 
            isolation: false 
          }

          filesize: {
            metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
            format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, auto
          }

          cursor_shape: {
            vi_insert: blink_line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
            vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
            emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
          }

          footer_mode: "25" # always, never, number_of_rows, auto
          float_precision: 2
          buffer_editor: "" # ctrl+o line buffer editor, fallback to $env.EDITOR and $env.VISUAL
          use_ansi_coloring: true
          bracketed_paste: true 
          edit_mode: vi # emacs, vi
          # shell_integration: false # enables terminal shell integration. Off by default, as some terminals have issues with this.
          render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
          #TODO use this? I do use the kitty terminal... 
          use_kitty_protocol: true # enables keyboard enhancement protocol implemented by kitty console, only if your terminal support this.
          highlight_resolved_externals: false 

          hooks: {
            pre_prompt: [{ null }] # run before the prompt is shown
            pre_execution: [{ null }] # run before the repl input is run
            env_change: {
              PWD: [{|before, after| null }] # run if the PWD environment is different since the last repl input
            }
            display_output: "if (term size).columns >= 100 { table -e } else { table }" # run to display the output of a pipeline
            # TODO when command_not_found, run `command-not-found {command}`
            command_not_found: { command-not-found } # return an error message when a command is not found
          }

          menus: [
            {
              name: completion_menu
              only_buffer_difference: false
              marker: "| "
              type: {
                layout: columnar
                columns: 4
                # col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
                col_padding: 2
              }
              style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
              }
            }
            {
              name: history_menu
              only_buffer_difference: true
              marker: "? "
              type: {
                layout: list
                page_size: 10
              }
              style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
              }
            }
            {
              name: help_menu
              only_buffer_difference: true
              marker: "? "
              type: {
                layout: description
                columns: 4
                col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
                col_padding: 2
                selection_rows: 4
                description_rows: 10
              }
              style: {
                text: green
                selected_text: green_reverse
                description_text: yellow
              }
            }
          ]

          keybindings: [
            {
              name: completion_menu
              modifier: none
              keycode: tab
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  { send: menu name: completion_menu }
                  { send: menunext }
                  { edit: complete }
                ]
              }
            }
            {
              name: history_menu
              modifier: control
              keycode: char_r
              mode: [vi_normal, vi_insert, emacs]
              event: { send: menu name: history_menu }
            }
            {
              name: help_menu
              modifier: none
              keycode: f1
              mode: [vi_normal, vi_insert, emacs]
              event: { send: menu name: help_menu }
            }
            {
              name: completion_previous_menu
              modifier: shift
              keycode: backtab
              mode: [vi_normal, vi_insert, emacs]
              event: { send: menuprevious }
            }
            {
              name: next_page_menu
              modifier: control
              keycode: char_x
              mode: emacs
              event: { send: menupagenext }
            }
            {
              name: undo_or_previous_page_menu
              modifier: control
              keycode: char_z
              mode: emacs
              event: {
                until: [
                  { send: menupageprevious }
                  { edit: undo }
                ]
              }
            }
            {
              name: escape
              modifier: none
              keycode: escape
              mode: [vi_normal, vi_insert, emacs]
              event: { send: esc }    # NOTE: does not appear to work
            }
            {
              name: cancel_command
              modifier: control
              keycode: char_c
              mode: [vi_normal, vi_insert, emacs]
              event: { send: ctrlc }
            }
            {
              name: quit_shell
              modifier: control
              keycode: char_d
              mode: [vi_normal, vi_insert, emacs]
              event: { send: ctrld }
            }
            {
              name: clear_screen
              modifier: control
              keycode: char_l
              mode: [vi_normal, vi_insert, emacs]
              event: { send: clearscreen }
            }
            {
              name: search_history
              modifier: control
              keycode: char_q
              mode: [vi_normal, vi_insert, emacs]
              event: { send: searchhistory }
            }
            {
              name: open_command_editor
              modifier: control
              keycode: char_o
              mode: [vi_normal, vi_insert, emacs]
              event: { send: openeditor }
            }
            {
              name: move_up
              modifier: none
              keycode: up
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  {send: menuup}
                  {send: up}
                ]
              }
            }
            {
              name: move_down
              modifier: none
              keycode: down
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  {send: menudown}
                  {send: down}
                ]
              }
            }
            {
              name: move_left
              modifier: none
              keycode: left
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  {send: menuleft}
                  {send: left}
                ]
              }
            }
            {
              name: move_right_or_take_history_hint
              modifier: none
              keycode: right
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  {send: historyhintcomplete}
                  {send: menuright}
                  {send: right}
                ]
              }
            }
            {
              name: move_one_word_left
              modifier: control
              keycode: left
              mode: [vi_normal, vi_insert, emacs]
              event: {edit: movewordleft}
            }
            {
              name: move_one_word_right_or_take_history_hint
              modifier: control
              keycode: right
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  {send: historyhintwordcomplete}
                  {edit: movewordright}
                ]
              }
            }
            {
              name: move_to_line_start
              modifier: none
              keycode: home
              mode: [vi_normal, vi_insert, emacs]
              event: {edit: movetolinestart}
            }
            {
              name: move_to_line_start
              modifier: control
              keycode: char_a
              mode: [vi_normal, vi_insert, emacs]
              event: {edit: movetolinestart}
            }
            {
              name: move_to_line_end_or_take_history_hint
              modifier: none
              keycode: end
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  {send: historyhintcomplete}
                  {edit: movetolineend}
                ]
              }
            }
            {
              name: move_to_line_end_or_take_history_hint
              modifier: control
              keycode: char_e
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  {send: historyhintcomplete}
                  {edit: movetolineend}
                ]
              }
            }
            {
              name: move_to_line_start
              modifier: control
              keycode: home
              mode: [vi_normal, vi_insert, emacs]
              event: {edit: movetolinestart}
            }
            {
              name: move_to_line_end
              modifier: control
              keycode: end
              mode: [vi_normal, vi_insert, emacs]
              event: {edit: movetolineend}
            }
            {
              name: move_up
              modifier: control
              keycode: char_p
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  {send: menuup}
                  {send: up}
                ]
              }
            }
            {
              name: move_down
              modifier: control
              keycode: char_t
              mode: [vi_normal, vi_insert, emacs]
              event: {
                until: [
                  {send: menudown}
                  {send: down}
                ]
              }
            }
            {
              name: delete_one_character_backward
              modifier: none
              keycode: backspace
              mode: [emacs, vi_insert]
              event: {edit: backspace}
            }
            {
              name: delete_one_word_backward
              modifier: control
              keycode: backspace
              mode: [emacs, vi_insert]
              event: {edit: backspaceword}
            }
            {
              name: delete_one_character_forward
              modifier: none
              keycode: delete
              mode: [emacs, vi_insert]
              event: {edit: delete}
            }
            {
              name: delete_one_character_forward
              modifier: control
              keycode: delete
              mode: [emacs, vi_insert]
              event: {edit: delete}
            }
            {
              name: delete_one_character_forward
              modifier: control
              keycode: char_h
              mode: [emacs, vi_insert]
              event: {edit: backspace}
            }
            {
              name: delete_one_word_backward
              modifier: control
              keycode: char_w
              mode: [emacs, vi_insert]
              event: {edit: backspaceword}
            }
            {
              name: move_left
              modifier: none
              keycode: backspace
              mode: vi_normal
              event: {edit: moveleft}
            }
            {
              name: newline_or_run_command
              modifier: none
              keycode: enter
              mode: emacs
              event: {send: enter}
            }
            {
              name: move_left
              modifier: control
              keycode: char_b
              mode: emacs
              event: {
                until: [
                  {send: menuleft}
                  {send: left}
                ]
              }
            }
            {
              name: move_right_or_take_history_hint
              modifier: control
              keycode: char_f
              mode: emacs
              event: {
                until: [
                  {send: historyhintcomplete}
                  {send: menuright}
                  {send: right}
                ]
              }
            }
            {
              name: redo_change
              modifier: control
              keycode: char_g
              mode: emacs
              event: {edit: redo}
            }
            {
              name: undo_change
              modifier: control
              keycode: char_z
              mode: emacs
              event: {edit: undo}
            }
            {
              name: paste_before
              modifier: control
              keycode: char_y
              mode: emacs
              event: {edit: pastecutbufferbefore}
            }
            {
              name: cut_word_left
              modifier: control
              keycode: char_w
              mode: emacs
              event: {edit: cutwordleft}
            }
            {
              name: cut_line_to_end
              modifier: control
              keycode: char_k
              mode: emacs
              event: {edit: cuttoend}
            }
            {
              name: cut_line_from_start
              modifier: control
              keycode: char_u
              mode: emacs
              event: {edit: cutfromstart}
            }
            {
              name: swap_graphemes
              modifier: control
              keycode: char_t
              mode: emacs
              event: {edit: swapgraphemes}
            }
            {
              name: move_one_word_left
              modifier: alt
              keycode: left
              mode: emacs
              event: {edit: movewordleft}
            }
            {
              name: move_one_word_right_or_take_history_hint
              modifier: alt
              keycode: right
              mode: emacs
              event: {
                until: [
                  {send: historyhintwordcomplete}
                  {edit: movewordright}
                ]
              }
            }
            {
              name: move_one_word_left
              modifier: alt
              keycode: char_b
              mode: emacs
              event: {edit: movewordleft}
            }
            {
              name: move_one_word_right_or_take_history_hint
              modifier: alt
              keycode: char_f
              mode: emacs
              event: {
                until: [
                  {send: historyhintwordcomplete}
                  {edit: movewordright}
                ]
              }
            }
            {
              name: delete_one_word_forward
              modifier: alt
              keycode: delete
              mode: emacs
              event: {edit: deleteword}
            }
            {
              name: delete_one_word_backward
              modifier: alt
              keycode: backspace
              mode: emacs
              event: {edit: backspaceword}
            }
            {
              name: delete_one_word_backward
              modifier: alt
              keycode: char_m
              mode: emacs
              event: {edit: backspaceword}
            }
            {
              name: cut_word_to_right
              modifier: alt
              keycode: char_d
              mode: emacs
              event: {edit: cutwordright}
            }
            {
              name: upper_case_word
              modifier: alt
              keycode: char_u
              mode: emacs
              event: {edit: uppercaseword}
            }
            {
              name: lower_case_word
              modifier: alt
              keycode: char_l
              mode: emacs
              event: {edit: lowercaseword}
            }
            {
              name: capitalize_char
              modifier: alt
              keycode: char_c
              mode: emacs
              event: {edit: capitalizechar}
            }
          ]
        }


        def cpu [] {ps | where cpu > 0 | sort-by cpu | reverse | first 10 }
        def ram [] {ps | where mem != '0 B' | sort-by mem | reverse | first 10 }

        def Backup [destinationPath] {
          rsync -auv --size-only ~/Pictures ~/Documents ~/share ~/nixfiles "$destinationPath"
        }
        

        def h [message] { 
          cd ~/nixfiles;
          try {
            git add ~/nixfiles; 
            home-manager switch --flake ~/nixfiles#${username};
            git commit ~/nixfiles -m "$message"; 
          }
          cd -
        }

        def N [message] { 
          try {
            sudo nixos-rebuild switch --flake ~/home/nixfiles#default;
            git add ~/nixfiles; 
            git commit ~/nixfiles -m ["$message"]; 
          }
        }


        alias rec = ffmpeg -f pulse -i 53 /tmp/output.wav

        # TODO move this all to nix syntax
        # TODO make universal nix variables for some of it? 

        let carapace_completer = { |spans|
        carapace $spans.0 nushell $spans | from json }
        $env.config = {
          edit_mode: vi,
          show_banner: false,
          completions: {
            case_sensitive: false 
            quick: true    
            partial: true 
            algorithm: "fuzzy"    # prefix or fuzzy
            external: {
              enable: true 
              max_results: 100 
              completer: $carapace_completer 
            }
          }
        } 

        export extern "lf" [
          --command                   # command to execute on client initialization
          --config: string            # path to the config file (instead of the usual paths)
          --cpuprofile: string        # path to the file to write the CPU profile
          --doc                       # show documentation
          --last-dir-path: string     # path to the file to write the last dir on exit (to use for cd)
          --log: string               # path to the log file to write messages
          --memprofile: string        # path to the file to write the memory profile
          --print-last-dir            # print the last dir to stdout on exit (to use for cd)
          --print-selection           # print the selected files to stdout on open (to use as open file dialog)
          --remote: string            # send remote command to server
          --selection-path: string    # path to the file to write selected files on open (to use as open file dialog)
          --server                    # start server (automatic)
          --single                    # start a client without server
          --version                   # show version
          --help                      # show help
        ]

    '';
  };  

      carapace.enable = true;
      carapace.enableNushellIntegration = true;
  
      starship = { enable = true;
      settings = {
                  # format = lib.concatStrings [
                  # "$battery"
                  # ];
        add_newline = true;
        character = { 
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
