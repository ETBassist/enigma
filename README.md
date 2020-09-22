# ENIGMA

Self-assessment:
* Functionality
  * 4: Crack feature is fully implemented. I'd like to go back at some point and figure out a more elegant solution than the one I came up with, but it works.
* Object Oriented Programming
  * 3.5: Inheritance is implemented wherein Enigma inherits from Rotor, and while it makes sense to me that it be thus, I'm not confident in that particular implementation. There's probably a better name for the class than "Rotor", but I was thinking of the physical Enigma machine and its design.
* Ruby Conventions and Mechanics
  * 3.5: Rubocop was a constant companion of mine throughout this project, and oh boy do they have opinions about ruby conventions. I believe that the most efficient enumerables were chosen, at least to the best of my knowledge.
* Test Driven Development
  * 3.5+: Mocks and Stubs have been implemented in two places; the first to stub out the `today` function in my testing to that the test would continue to pass even after the date has changed and so that the testing does not rely upon the functionality of the Date class. The other place it was implemented was in the test for the `crack` method, wherein the `force_key` method has been stubbed out because it has already been tested on its own and would slow the overall test speed down were it not stubbed out. However, I couldn't stub out the `rand` method used in the generation of the key, and I feel that's something I should be able to do.
* Version Control
  * 4: Definitely more than 40 commits (111 at the moment of writing this). Pull Requests contain a short list of the features or methods added, and commits do not contain multiple pieces of functionality (although some contain minor typo corrections.)
