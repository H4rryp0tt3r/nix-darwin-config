.PHONY: update
update:
	home-manager switch --flake .#h4rryp0tt3r

.PHONY: clean
clean:
	nix-collect-garbage -d
