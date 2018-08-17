project('libgee', 'vala', 'c',
	version : '0.20.3')

gio = dependency('gio-2.0')

VALADEPS = 'gio-2.0'
PCDEPS = 'gio-2.0'

API_VERSION = '0.8'

ndebug = get_option('b_ndebug')
if ndebug == 'true' or (ndebug == 'if-release' and not get_option('debug'))
  add_project_arguments(['-DG_DISABLE_CAST_CHECKS', '-DG_DISABLE_ASSERT', '-DG_DISABLE_CHECKS'],
			language : 'c')
endif

conf = configuration_data()
conf.set('prefix', get_option('prefix'))
conf.set('exec_prefix', '${prefix}')
conf.set('libdir', join_paths ('${prefix}',get_option ('libdir')))
conf.set('includedir', join_paths ('${prefix}',get_option ('includedir')))
conf.set('datarootdir', join_paths ('${prefix}','share'))
conf.set('datadir', '${datarootdir}')
conf.set('VALADEPS', VALADEPS)
conf.set('PCDEPS', PCDEPS)
conf.set('VERSION', meson.project_version())
conf.set('API_VERSION', API_VERSION)

configure_file(input : 'gee-0.8.pc.in',
	output : 'gee-@0@.pc'.format(API_VERSION),
	configuration : conf,
	install : true,
	install_dir : join_paths(get_option('libdir'), 'pkgconfig'))

vapidir = join_paths (get_option('datadir'),'vala','vapi')

configure_file(input : 'gee.deps.in',
	output : 'gee-@0@.deps'.format(API_VERSION),
	configuration : conf,
	install : true,
	install_dir : vapidir)

# Coverage is supported in Meson, so no code is added to libgee
# for coverage how-to, go to: http://mesonbuild.com/howtox.html#producing-a-coverage-report



subdir('utils')
subdir('gee')
subdir('doc')
subdir('tests')

benchmarks_opt = get_option ('enable-benchmark')
if benchmarks_opt
	subdir('benchmark')
endif
