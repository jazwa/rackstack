/*
  Slack config to standardize different usages of slack/tolerance values.

  The purpose of this config is to introduce some consistency with how slack values defined in code. E.g. Why is the
  slack value defined as 0.3 in this file, but 0.4 in another? This will also allow model-level adjustments for tighter
  fitting parts, for when it might not convenient to adjust the actual 3d printer (using a 3d printer at a makerspace,
  for example).

  Some important details:
    - The general philosophy for slack applications in this project is to subtract space from sockets, while not
      modifying the plugs. TODO: enforce this
    - Values are signed. Positive values can be interpreted as how much to remove from the socket along some dimension.
    - This shouldn't be used to compensate for more serious part shrinkage (> +-0.5mm differences)
*/

// TODO change this
xySlack = 0.2;

radiusXYSlack = xySlack/2;

zSlack = 0.0; // TODO figure out nice default value for this. keep in mind z shrinkage

overhangSlack = 0.4;

supportedOverhangSlack = 0.4;


// special slack cases
xBarYBarDovetailSlack = xySlack*2;