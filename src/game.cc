#include <iostream>
#include <fstream>
#include <cstring>
#include <exception>

#include "game.hh"

#include "levels/menu.hh"
#include "levels/1.hh"

#ifdef _WIN32
#include <windows.h>
#include <shlobj.h>
#endif

Game::Game() {
	std::vector<Level *> levels;
	levels.push_back(new Level1());

	this->levels.push_back(new LevelMenu(this, levels.size()));
	for (auto level : levels) {
		this->levels.push_back(level);
	}
	levels.clear();
}

Game::~Game() {
	for (auto level : this->levels) {
		delete level;
	}
	this->levels.clear();
}

void Game::main() {
	this->saveFileRead();

	for (int startLevel = -1; this->startLevel || startLevel;) {
		startLevel = this->startLevel;
		this->startLevel = 0;

		Level * level = this->levels.at(startLevel);
		bool won = level->main();

		// Maybe update finished levels.
		if (won && startLevel > this->finishedLevel) {
			this->finishedLevel = startLevel;

			this->saveFileWrite();

			std::cout << "Your progress has been saved." << std::endl;
		}
	}
}

std::string Game::saveFilePath() {
	std::string dir;
	char sep = '/';
	std::string name = "CyberAttackSave.txt";

#ifdef _WIN32

	CHAR docs[MAX_PATH];
	docs[0] = '\0';
	SHGetFolderPathA(NULL, CSIDL_PERSONAL, NULL, SHGFP_TYPE_CURRENT, docs);
	if (!strlen(docs)) {
		throw std::runtime_error("Could not find user documents directory");
	}
	dir = docs;
	sep = '\\';

#else

	const char * home = getenv("HOME");
	if (!home || !strlen(home)) {
		throw std::runtime_error("Could not find user home directory");
	}
	dir = std::string(home) + sep + "Documents";

#endif

	return dir + sep + name;
}

void Game::saveFileRead() {
	auto path = saveFilePath();
	std::ifstream file(path.c_str());
	if (!file.good()) {
		return;
	}

	// Read the save file.
	std::string data;
	file >> data;
	file.close();

	// Parse the saved level.
	int savedLevel = 0;
	sscanf(data.c_str(), "%d", &savedLevel);

	// Sanity check.
	if (savedLevel > 0 && savedLevel < (int)this->levels.size()) {
		this->finishedLevel = savedLevel;
	}
}

void Game::saveFileWrite() {
	auto path = saveFilePath();
	std::ofstream file(path.c_str());
	file << this->finishedLevel;
	file.close();
}
