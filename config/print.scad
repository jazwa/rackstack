// Print settings config file

/**********************************************************************************************************************
  Slack config to standardize different usages of slack/tolerance values.

  The purpose of this config is to introduce some consistency with how slack values defined in code. E.g. Why is the
  slack value defined as 0.3 in this file, but 0.4 in another? This will also allow model-level adjustments for tighter
  fitting parts, for when it might not convenient to adjust the actual 3d printer (using a 3d printer at a makerspace,
  for example).

  Some important details:
    - The general philosophy for slack applications in this project is to subtract space from sockets, while not
      modifying the plugs.
    - Values are signed. Positive values can be interpreted as how much to remove from the socket along some dimension.
    - These values depend on print orientation and it's assumed parts are printed in their recommended orientations.
*/
xySlack = 0.25;

radiusXYSlack = xySlack/2;

zSlack = 0.0;

overhangSlack = 0.5;

supportedOverhangSlack = 0.5;

// special slack cases, change if neccessary
xBarYBarDovetailSlack = xySlack;

/**********************************************************************************************************************
  Printer/slicer config, mainly used for calculating some special overhangs.
*/
defaultLayerHeight = 0.3;
