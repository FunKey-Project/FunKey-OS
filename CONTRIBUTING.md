## How to contribute to FunKey-OS

#### **Did you find a bug?**

* **Ensure the bug was not already reported** by searching on GitHub under [Issues](https://github.com/FunKey-Project/FunKey-OS/issues).

* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/FunKey-Project/FunKey-OS/issues/new). Be sure to include a **title and clear description**, as much relevant information as possible, and a **code sample** or an **executable test case** demonstrating the expected behavior that is not occurring.

* If possible, use the relevant bug report templates to create the issue.

#### **Did you write a patch that fixes a bug?**

* Open a new GitHub pull request with the patch.

* Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable.

#### **Did you fix whitespace, format code, or make a purely cosmetic patch?**

Changes that are cosmetic in nature and do not add anything substantial to the stability, functionality, or testability of FunKey-OS will generally not be accepted.
I know this might be thinking, "sure, it might not be adding much value, but I already wrote the code, so the cost is already paid – by me – so why not just merge it"? The reason is that there are a lot of hidden cost in addition to writing the code itself.

- Someone need to spend the time to review the patch. However trivial the changes might seem, there might be some subtle reasons the original code are written this way and any tiny changes have the possibility of altering behaviour and introducing bugs. (For example, in this case, do you know if self.name= and assign_names doesn't depend on controller_name being set? I don't – so I'd have to look it up and make sure. Also, there is a travis failure associated with this PR, it's probably a random failure, but I'd have to investigate to be sure). All of these work takes away time and energy that could be spent on actual features and bug fixes.
- It creates noise. There may be currently people watching this repo – these people will get an email from github everytime someone opens a new issue, comment on a ticket, etc. They do this (probably) because they want to watch out for PRs and issues that they care about, and these PRs will further lower the signal-to-noise ratio in these notification emails.
- It pollutes the git history. When someone need to investigate a bug and git blame these lines in the future, they'll hit this "refactor" commit which is not very useful.
I- t makes backporting bug fixes harder.
Theses are just some examples of the hidden costs that are not so apparent from the surface.

It's awesome that you want to contribute to FunKey-OS, please keep the PRs coming! All we ask is that you refrain from sending these types of changes in the future (and read the contribution guide :). I hope you'll understand!

#### **Do you intend to add a new feature or change an existing one?**

* Suggest your change in the [FunKey-OS Discord development channel](https://discord.com/channels/728036844142592000/728075622089490513) and start writing code.

* Do not open an issue on GitHub until you have collected positive feedback about the change. GitHub issues are primarily intended for bug reports and fixes.

#### **Do you have questions about the source code?**

* Ask any question about how to use FunKey-OS in the [FunKey-OS Discord development channel](https://discord.com/channels/728036844142592000/728075622089490513).

#### **Do you want to contribute to the FunKey-OS documentation?**

* Not yet

Thanks! :heart: :heart: :heart:

The FunKey-OS Team
