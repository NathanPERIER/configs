#!/usr/bin/fish

if not contains ~/.local/bin $PATH
	set PATH $PATH ~/.local/bin
end

if not contains /usr/sbin $PATH
	set PATH /usr/sbin $PATH
end


if test -f ~/.config/fish/variables.fish
	. ~/.config/fish/variables.fish
end

if test -f ~/.config/fish/local.fish
	. ~/.config/fish/local.fish
end

if test -f ~/.config/fish/aliases.fish
	. ~/.config/fish/aliases.fish
end

