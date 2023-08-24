# try_prokka1 (on-going | self-studies)
**Self-Introduction**
After completing my unit in FIT2081 (Mobile Application Development) in June 2023, I discovered my passion for UI design and application development, leading me to explore the exciting tool called Flutter in July 2023.

Simultaneously, in the first half of 2023, I accidently embarked on a journey into bioinformatics outside of my course of study, encountering Prokka, a Linux tool used for rapid prokaryotic genome annotation, through studies and research in Advanced Bioinformatics. Introduced in this [paper](https://academic.oup.com/bioinformatics/article/30/14/2068/2390517?login=false), Prokka, along with the idea of building user-friendly GUIs exemplified by tools like [TBtools](https://bio.tools/tbtools), inspired me to launch the project try_prokka1 at the end of July 2023.

This project serves as a personal exploration to become familiar with Flutter, understand new architectural patterns like MVVM, and immerse in the fascinating field of bioinformatics (all new but exciting domains I encountered in 2023). 

The overarching goal is to make Linux command-line tools, particularly Prokka, more accessible and user-friendly by crafting a GUI that bridges the gap between Linux's capabilities and modern GUI's ease of use, enabling complex tasks without the need for full syntax.

**Current Features (Subject to Future Improvements)**
 
    File Management: Facilitates user interaction with genome annotation files (an opportunity to understand MVVM).
    Prokka Integration: Offers functionalities such as checking Prokka's version and executing genome annotation tasks 
     checking version by matching the command prokka --version,this is also the step to figure out is the path correct
     executing genome annotation tasks by matching the command prokka --kingdom (selecting the Annotation mode)
    Responsive UI: Adapts layout according to screen size for a seamless user experience.
    Custom Theme and Error Handling: Enhances UI appeal and stability.

**Getting Started**
Prerequisites
Flutter (Follow the official guide for installation)
Prokka
...
Configure Prokka Path: (the current environment path is not fixed--will improve later; please place the path to Prokka in the config file)
