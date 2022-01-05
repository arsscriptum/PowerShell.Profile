# Powershell Profile

This repository contains my personal Powershell profile script and the accompaing scripts that are loaded when I launch a PowerShell session.

I have an important criteria regarding my Pwsh Profile scripts; keep everything small, simple maintainable. If I need to add a new function in my profile, carefully weight the pros/cons of adding it
to the profile vs to a Pwsh Module. 

It's very important that I keep my profile loading delay < 1.5-2sec.

## Save-Profile function

When My profile needs to be savec, use the Save-Profile function.
