# TODO - Fix jQuery Reference Error in wizard.js

## Problem
`wizard.js:4 Uncaught ReferenceError: $ is not defined`

## Root Cause
The file uses `$` (jQuery) before importing it. The `import $ from 'jquery'` statement is at the end of the file instead of at the beginning.

## Fix Steps
1. Move `import $ from 'jquery'` to the top of wizard.js (before any code that uses $)
2. Remove duplicate code sections (the same code is repeated twice)
3. Clean up the file structure

## Status
- [x] Fix wizard.js - move jQuery import to top and remove duplicates
- [ ] Verify the fix works

