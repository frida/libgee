
# TODO: port to use API_VERSION in namespace declaration
#nsinfo = configure_file(input : 'namespace-info.vala.in',
#	output : 'namespace-info.vala',
#	configuration : conf)
#namespaceinfo_dep = declare_dependency (sources : nsinfo)

# TODO: Add translation support
#confh = configuration_data ()
#confh.set_quoted('PACKAGE_LOCALE_DIR', get_option('prefix') / get_option('datadir') / 'locale')
#confh.set_quoted('GETTEXT_PACKAGE', 'GXml')
#configure_file(output : 'config.h',
#	configuration : confh)

gee_sources = files([
	'assemblyinfo.vala',
	'abstractbidirlist.vala',
	'abstractbidirsortedset.vala',
	'abstractbidirsortedmap.vala',
	'abstractcollection.vala',
	'abstractlist.vala',
	'abstractmap.vala',
	'abstractmultimap.vala',
	'abstractmultiset.vala',
	'abstractqueue.vala',
	'abstractset.vala',
	'abstractsortedmap.vala',
	'abstractsortedset.vala',
	'arraylist.vala',
	'arrayqueue.vala',
	'bidiriterator.vala',
	'bidirlist.vala',
	'bidirlistiterator.vala',
	'bidirmapiterator.vala',
	'bidirsortedset.vala',
	'bidirsortedmap.vala',
	'collection.vala',
	'comparable.vala',
	'concurrentlist.vala',
	'concurrentset.vala',
	'deque.vala',
	'functions.vala',
	'future.vala',
	'hashable.vala',
	'hashmap.vala',
	'hashmultimap.vala',
	'hashmultiset.vala',
	'hashset.vala',
	'hazardpointer.vala',
	'iterable.vala',
	'iterator.vala',
	'lazy.vala',
	'linkedlist.vala',
	'lightmapfuture.vala',
	'list.vala',
	'listiterator.vala',
	'map.vala',
	'mapiterator.vala',
	'multimap.vala',
	'multiset.vala',
	'priorityqueue.vala',
	'promise.vala',
	'queue.vala',
	'readonlybidirlist.vala',
	'readonlybidirsortedset.vala',
	'readonlybidirsortedmap.vala',
	'readonlycollection.vala',
	'readonlylist.vala',
	'readonlymap.vala',
	'readonlymultimap.vala',
	'readonlymultiset.vala',
	'readonlyset.vala',
	'readonlysortedmap.vala',
	'readonlysortedset.vala',
	'set.vala',
	'sortedmap.vala',
	'sortedset.vala',
	'streamiterator.vala',
	'task.vala',
	'teeiterator.vala',
	'timsort.vala',
	'traversable.vala',
	'treemap.vala',
	'treemultimap.vala',
	'treemultiset.vala',
	'treeset.vala',
	'unfolditerator.vala',
	'unrolledlinkedlist.vala'
])

includehdir = include_directories('.')
includehdir_dep = declare_dependency(include_directories : includehdir)

internal_asserts_opt = get_option('disable-internal-asserts')
internal_asserts_args = []
if internal_asserts_opt
	internal_asserts_args += ['-D','DISABLE_INTERNAL_ASSERTS']
endif

enable_consistency_check_opt = get_option('enable-consistency-check')
enable_consistency_check_args = []
if enable_consistency_check_opt
	enable_consistency_check_args += ['-D','CONSISTENCY_CHECKS']
endif

disable_introspection = get_option('disable-introspection')

gee = library(gee_api_name, gee_sources,
	version : API_VERSION,
	vala_header : 'gee.h',
	vala_vapi : f'@gee_api_name@.vapi',
	vala_gir : 'Gee-@0@.gir'.format(API_VERSION),
	vala_args : ['--pkg=gio-2.0', '--pkg=geeutils'] + internal_asserts_args + enable_consistency_check_args,
	dependencies : [ gio, include_utils_h_dir_dep ],
	install : true,
	install_dir : [
		true,
		get_option('includedir') / gee_api_name,
		true,
		not disable_introspection,
	])

gee_dep = declare_dependency(
	include_directories : include_directories('.'),
	link_with : gee)

meson.override_dependency(gee_api_name, gee_dep)

pkg = import('pkgconfig')
pkg.generate(gee,
	name : 'libgee',
	description : 'The GObject collection library',
	filebase : gee_api_name,
	subdirs : gee_api_name)

if disable_introspection
else
	g_ir_compiler = find_program('g-ir-compiler', required: false)
	if g_ir_compiler.found()
		custom_target('typelib',
			command: [
				g_ir_compiler,
				'--shared-library', 'libgee-@0@.so'.format (API_VERSION),
				'--output', '@OUTPUT@',
				meson.current_build_dir() / f'Gee-@API_VERSION@.gir',
			],
			output: 'Gee-@0@.typelib'.format(API_VERSION),
			depends: gee,
			install: true,
			install_dir: get_option('libdir') / 'girepository-1.0')
	endif
endif
