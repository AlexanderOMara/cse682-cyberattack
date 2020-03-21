#pragma once

#include "string"
#include "vector"

#include "level.hh"

class Game {
	public:
		/**
		 * Flag to start a level instead of menu.
		 */
		int startLevel = 0;

		/**
		 * Current level of completion.
		 */
		int finishedLevel = 0;

		/**
		 * Constructor.
		 */
		Game();

		/**
		 * Destructor.
		 */
		~Game();

		/**
		 * Main loop.
		 */
		void main();

	protected:
		/**
		 * Level instances.
		 */
		std::vector<Level *> levels;

		/**
		 * Get save file path.
		 *
		 * @returns The save file path.
		 */
		std::string saveFilePath();

		/**
		 * Read save file into finishedLevel if exists.
		 */
		void saveFileRead();

		/**
		 * Write finishedLevel into save file.
		 */
		void saveFileWrite();
};
