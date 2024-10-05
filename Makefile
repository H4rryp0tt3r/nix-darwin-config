.PHONY: update
update:
	darwin-rebuild switch --flake .

.PHONY: clean
clean:
	nix-collect-garbage -d

.PHONY: clean-everything
clean-everything:
	sudo nix-collect-garbage -d

.PHONY: list-gen
list-gen:
	darwin-rebuild --list-generations
