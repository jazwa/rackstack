import argparse

parser = argparse.ArgumentParser(
    prog='rbuild',
    description='CLI-based helper utility to build project items',
    epilog='That\'s all folks!')

parser.add_argument('build')
#parser.add_argument('-c', '--count')      # option that takes a value
#parser.add_argument('-v', '--verbose', action='store_true')  # on/off flag

args = parser.parse_args()
print(args.build)
