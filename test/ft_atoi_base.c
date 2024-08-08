/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_atoi_base.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdameros <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/08/09 22:39:58 by tdameros          #+#    #+#             */
/*   Updated: 2022/08/09 23:28:19 by tdameros         ###   ########lyon.fr   */
/*                                                                            */
/* ************************************************************************** */

#include <stdbool.h>

#include "libasm.h"
#include "utest.h"
#include "utils.h"

UTEST(ft_atoi_base, simple_binary) {
  ASSERT_EQ(ft_atoi_base("11", "01"), 3);
}

UTEST(ft_atoi_base, binary_byte) {
  ASSERT_EQ(ft_atoi_base("11111111", "01"), 255);
}

UTEST(ft_atoi_base, convert_decimal_string_to_integer) {
  ASSERT_EQ(ft_atoi_base("123", "0123456789"), 123);
}

UTEST(ft_atoi_base, convert_hexadecimal_string_to_integer) {
  ASSERT_EQ(ft_atoi_base("FF", "0123456789ABCDEF"), 255);
}

UTEST(ft_atoi_base, convert_binary_string_to_integer_with_leading_zeros) {
  ASSERT_EQ(ft_atoi_base("00001111", "01"), 15);
}

UTEST(ft_atoi_base, convert_empty_string_to_integer) {
  ASSERT_EQ(ft_atoi_base("", "01"), 0);
}

UTEST(ft_atoi_base, convert_string_with_invalid_characters_to_integer) {
  ASSERT_EQ(ft_atoi_base("12G4", "0123456789ABCDEF"), 18);
}

UTEST(ft_atoi_base, convert_string_with_negative_sign_to_integer) {
  ASSERT_EQ(ft_atoi_base("-111", "01"), -7);
}

UTEST(ft_atoi_base, convert_string_with_multiple_negative_signs_to_integer) {
  ASSERT_EQ(ft_atoi_base("--1111", "01"), 15);
}

UTEST(ft_atoi_base,
      convert_string_with_positive_and_negative_signs_to_integer) {
  ASSERT_EQ(ft_atoi_base("-+1111", "01"), -15);
}

UTEST(ft_atoi_base, convert_string_with_invalid_base_to_integer) {
  ASSERT_EQ(ft_atoi_base("123", "0123456789AAB"), 0);
}

UTEST(ft_atoi_base, invalid_base_with_spaces) {
  ASSERT_EQ(ft_atoi_base("42", " \r\t"), 0);
}

UTEST(ft_atoi_base, invalid_base_with_duplicate_char) {
  ASSERT_EQ(ft_atoi_base("42", "01245670"), 0);
}

UTEST(ft_atoi_base, invalid_base_with_minus) {
  ASSERT_EQ(ft_atoi_base("42", "0124-567"), 0);
}

UTEST(ft_atoi_base, invalid_base_with_plus) {
  ASSERT_EQ(ft_atoi_base("42", "0+124567"), 0);
}
