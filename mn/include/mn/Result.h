#pragma once

#include "mn/Str.h"
#include "mn/Fmt.h"
#include "mn/Assert.h"

namespace mn
{
	// an error message (this type uses RAII to manage its memory)
	struct Err
	{
		Str msg;

		// creates a new empty error (not an error)
		Err(): msg(str_new()) {}

		// creates a new error with the given error message
		template<typename... TArgs>
		Err(const char* fmt, TArgs&& ... args)
			:msg(strf(fmt, std::forward<TArgs>(args)...))
		{}

		Err(const Err& other)
			:msg(clone(other.msg))
		{}

		Err(Err&& other)
			:msg(other.msg)
		{
			other.msg = str_new();
		}

		~Err() { str_free(msg); }

		Err&
		operator=(const Err& other)
		{
			str_clear(msg);
			str_push(msg, other.msg);
			return *this;
		}

		Err&
		operator=(Err&& other)
		{
			str_free(msg);
			msg = other.msg;
			other.msg = str_new();
			return *this;
		}

		// casts the given error to a boolean, (false = no error, true = error exists)
		explicit operator bool() const { return msg.count != 0; }
		bool operator==(bool v) const { return (msg.count != 0) == v; }
		bool operator!=(bool v) const { return !operator==(v); }
	};

	// represents a result of a function which can fail, it holds either the value or the error
	// error types shouldn't be of the same type as value types
	template<typename T, typename E = Err>
	struct Result
	{
		enum STATE
		{
			STATE_EMPTY = 0,
			STATE_ERROR = 1,
			STATE_VALUE = 2,
		};

		static_assert(!std::is_same_v<Err, T>, "Error can't be of the same type as value");

		inline static constexpr size_t size = sizeof(T) > sizeof(E) ? sizeof(T) : sizeof(E);
		inline static constexpr size_t alignment = alignof(T) > alignof(E) ? alignof(T) : alignof(E);
		alignas(alignment) char _buffer[size];
		STATE state;

		// creates a result instance from an error
		Result(E e)
		{
			::new (_buffer) E(e);
			state = STATE_ERROR;
		}

		// creates a result instance from a value
		template<typename... TArgs>
		Result(TArgs&& ... args)
		{
			::new (_buffer) T(std::forward<TArgs>(args)...);
			state = STATE_VALUE;
		}

		Result(const Result&) = delete;

		Result(Result&&) = default;

		Result& operator=(const Result&) = delete;

		Result& operator=(Result&&) = default;

		~Result()
		{
			if (state & STATE_ERROR)
			{
				auto err = (E*)_buffer;
				err->~E();
			}

			if (state & STATE_VALUE)
			{
				auto val = (T*)_buffer;
				val->~T();
			}
		};

		bool has_error() const { return state & STATE_ERROR; }
		bool has_value() const { return state & STATE_VALUE; }
		const E& error() const
		{
			mn_assert(has_error());
			return *(const E*)_buffer;
		}
		E& error()
		{
			mn_assert(has_error());
			return *(E*)_buffer;
		}
		T& value()
		{
			mn_assert(has_value());
			return *(T*)_buffer;
		}
	};
}

namespace fmt
{
	template<>
	struct formatter<mn::Err>
	{
		template<typename ParseContext>
		constexpr auto
		parse(ParseContext &ctx)
		{
			return ctx.begin();
		}

		template<typename FormatContext>
		auto
		format(const mn::Err &err, FormatContext &ctx)
		{
			return format_to(ctx.out(), "{}", err.msg);
		}
	};
} // namespace fmt
