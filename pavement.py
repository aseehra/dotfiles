from paver.easy import *
import itertools

rc_dir = path(__file__).abspath().parent / 'rc'
options.base_length = len(rc_dir.splitall())

@task
def env():
    '''
    Sets up global environment. Assumes root privileges.
    '''
    pass

@task
def rc():
    '''
    '''
    for dir in itertools.chain([rc_dir], rc_dir.walkdirs()):
        create_dir(dir)
        link_files(dir)
        copy_base_files(dir)
        append_platform(dir)

def to_dotfile(src, strip=None):
    '''
    Helper function to convert a path from a non-dotfile to a dotfile
    '''
    target = src.splitall()[options.base_length:]
    if len(target) <= 0:
        return None
    target[0] = '.' + target[0]
    if strip is not None:
        target[-1] = target[-1].rsplit(strip)[0]
    return path.joinpath(path('~'), *target).expand()

def copy_base_files(dir):
    for file in dir.files('*___base'):
        target = to_dotfile(file, '___base')
        if target:
            file.copy(target)

def create_dir(dir):
    target = to_dotfile(dir)
    if target:
        target.makedirs()

def link_files(dir):
    linkables = set(dir.files()) - set(dir.files('*___*'))
    for src in linkables:
        target = to_dotfile(src)
        if target is None:
            continue
        try:
            if target.exists:
                target.remove()
            src.symlink(target)
        except OSError as error:
            print str(error) + ': ' + target

def append_platform(dir):
    try:
        options.platform
    except AttributeError:
        options.platform = 'linux'

    suffix = '___' + options.platform
    for file in dir.files('*' + suffix):
        target = to_dotfile(file, suffix)
        if target is None:
            continue
        target.write_text(file.text(), append=True)
