project('libgee', 'vala', 'c',
	version : '0.20.6')

cc = meson.get_compiler('c')

if meson.is_subproject()
  add_project_arguments('--disable-warnings', language: 'vala')
  if cc.get_argument_syntax() != 'msvc'
    add_project_arguments('-w', language: 'c')
  endif
endif

gio = dependency('gio-2.0')

VALADEPS = 'gio-2.0'
PCDEPS = 'gio-2.0'

API_VERSION = '0.8'

gee_api_name = f'gee-@API_VERSION@'

if get_option('default_library') == 'static'
  add_project_arguments('-DVALA_EXTERN=extern', language : 'c')
endif

ndebug = get_option('b_ndebug')
if ndebug == 'true' or (ndebug == 'if-release' and not get_option('debug'))
  add_project_arguments(['-DG_DISABLE_CAST_CHECKS', '-DG_DISABLE_ASSERT', '-DG_DISABLE_CHECKS'],
			language : 'c')
endif

if cc.get_argument_syntax() == 'msvc'
  add_project_arguments('-D_CRT_DECLARE_NONSTDC_NAMES=0', language : 'c')
endif

conf = configuration_data()
conf.set('prefix', get_option('prefix'))
conf.set('exec_prefix', '${prefix}')
conf.set('libdir', '${prefix}' / get_option('libdir'))
conf.set('includedir', '${prefix}' / get_option('includedir'))
conf.set('datarootdir', '${prefix}' / 'share')
conf.set('datadir', '${datarootdir}')
conf.set('VALADEPS', VALADEPS)
conf.set('PCDEPS', PCDEPS)
conf.set('VERSION', meson.project_version())
conf.set('API_VERSION', API_VERSION)

vapidir = get_option('datadir') / 'vala' / 'vapi'

configure_file(input : 'gee.deps.in',
	output : f'@gee_api_name@.deps',
	configuration : conf,
	install : true,
	install_dir : vapidir)

# Coverage is supported in Meson, so no code is added to libgee
# for coverage how-to, go to: http://mesonbuild.com/howtox.html#producing-a-coverage-report

subdir('utils')
subdir('gee')
subdir('doc')
subdir('tests')

benchmarks_opt = get_option('enable-benchmark')
if benchmarks_opt
	subdir('benchmark')
endif
