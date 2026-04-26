.PHONY: test install lint help

help:
	@echo "c4-skills Makefile"
	@echo "------------------"
	@echo "make test    - Run the full test suite (Structural, Sandbox, Behavioral)"
	@echo "make install - Run the universal installer to equip your local agent"
	@echo "make lint    - (Alias for test) Validate all skills and examples"

test:
	@cd tests && ./test-skill-format.sh

install:
	@./install.sh

lint: test
