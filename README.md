# Cave Story(+) Autosplitters
LiveSplit autosplitters for Cave Story (original freeware version) and Cave Story+ (Steam/Humble PC versions).

Credits for most of this work goes to magmapeach, whose Cave Story (freeware) Best Ending autosplitter I used as the basis for this autosplitter.
You can find their original autosplitter linked on the [Cave Story sr.c resources page](https://www.speedrun.com/cave_story/resources).

## Supported Speedrun Categories
Currently, the following categories are officially supported on all difficulty settings:
- Best Ending
- Normal Ending
- Bad Ending
- Get Panties

Other categories that are similar to one of the above or start from the beginning of the game may also partially or fully work.

The challenge modes in Cave Story+ are *not* supported. Support for these categories is planned for a future release.

## Usage Instructions
1. Download the file corresponding to which version of Cave Story you have:
   * For the Steam version of Cave Story+, download "cave-story+-steam.asl".
   * For the Humble version of Cave Story+, download "cave-story+-humble.asl".
   * For the original freeware version of Cave Story, download "cave-story.asl" **or** either of the two Cave Story+ autosplitters listed above.
2. Right-click LiveSplit, choose "Edit Layout...", and add a "Scriptable Auto Splitter" component (under "Control").
3. Go to Layout Settings, click on the "Scriptable Auto Splitter" tab, click "Browse..." and select the file that you saved in Step 1.
4. (Optional) Check/Uncheck the boxes corresponding to where you want the autosplitter to split.
Note that you are not required to trigger all of these splits in order or at all in your run; it is okay, for instance, to leave the "Got Normal Ending" split checked even if you are doing a Best Ending run.

### Additional Remarks
- The autosplitter does not create any splits for you; it merely presses the button at the right times.
You will still have to set up split names, other layout settings, etc. yourself.
- Under "Options" (below where you selected the file in Step 3), you are able to select
whether you want the autosplitter to automatically start, split, and/or reset.
If the "Reset" box is checked, the autosplitter will reset whenever the game is closed.
I personally would recommend unchecking this box and doing resets manually, but if you
would prefer having automated resets, that's why that option is there.

## Known Issues

- In Cave Story+, if the jukebox is unlocked on the title screen (by beating Hell in under 3 minutes), then the autosplitter will start the timer if you change the music.
