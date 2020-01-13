#include <mn/IO.h>
#include <mn/File.h>
#include <mn/Defer.h>
#include <mn/Thread.h>
#include <mn/Path.h>

int
main()
{
	auto o = mn::file_open("other.bin", mn::IO_MODE::READ_WRITE, mn::OPEN_MODE::CREATE_OVERWRITE);

	auto f = mn::file_open("koko.bin", mn::IO_MODE::READ_WRITE, mn::OPEN_MODE::OPEN_ONLY);

	mn::file_write_lock(f, 0, 8);

	uint64_t v = 0;
	auto r = mn::file_read(f, mn::block_from(v));
	assert(r == 8);

	mn::file_write_unlock(f, 0, 8);

	mn::print("Version '{}'\n", v);

	v = 0;
	mn::file_write(o, mn::block_from(v));

	mn::file_remove("koko.bin");
	mn::file_move("other.bin", "koko.bin");

	mn::file_close(o);
	mn::file_close(f);
	return 0;
}