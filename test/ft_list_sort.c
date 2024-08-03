/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_list_sort.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tdameros <tdameros@student.42lyon.fr>      +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/07/25 18:35:00 by tdameros          #+#    #+#             */
/*   Updated: 2024/07/25 18:35:00 by tdameros         ###   ########lyon.fr   */
/*                                                                            */
/* ************************************************************************** */

#include <string.h>

#include "libasm.h"
#include "utest.h"
#include "utils.h"

UTEST(ft_list_sort, null_list) {
  ft_list_sort(NULL, &strcmp);
  ASSERT_EQ(errno, 0);
}

UTEST(ft_list_sort, empty_list) {
  t_list *list = NULL;
  ft_list_sort(&list, &strcmp);
  ASSERT_EQ(list, NULL);
}

UTEST(ft_list_sort, null_cmp) {
  t_list *list = ft_create_elem("Hello, World!");
  ft_list_sort(&list, NULL);
  ASSERT_EQ(list->data, "Hello, World!");
  ASSERT_EQ(list->next, NULL);
  free_list(list);
}

UTEST(ft_list_sort, single_node) {
  t_list *list = NULL;
  int a = 42;

  ft_list_push_front(&list, &a);

  ft_list_sort(&list, compare_int);
  ASSERT_EQ(*(int *)list->data, 42);
  free_list(list);
}

UTEST(ft_list_sort, two_nodes) {
  t_list *list = NULL;
  int a = 42;
  int b = 1;

  ft_list_push_front(&list, &a);
  ft_list_push_front(&list, &b);

  ft_list_sort(&list, compare_int);
  ASSERT_EQ(*(int *)list->data, 1);
  ASSERT_EQ(*(int *)list->next->data, 42);
  free_list(list);
}

UTEST(ft_list_sort, multiple_nodes) {
  t_list *list = NULL;
  int a = 42;
  int b = 1;
  int c = 21;
  int d = 3;
  int e = 7;
  int expected[] = {1, 3, 7, 21, 42};

  ft_list_push_front(&list, &a);
  ft_list_push_front(&list, &b);
  ft_list_push_front(&list, &c);
  ft_list_push_front(&list, &d);
  ft_list_push_front(&list, &e);

  ft_list_sort(&list, &compare_int);

  t_list *tmp = list;
  for (int i = 0; i < 5; i++) {
    ASSERT_EQ(*(int *)tmp->data, expected[i]);
    tmp = tmp->next;
  }

  free_list(list);
}

UTEST(ft_list_sort, mutiple_strings) {
  t_list *list = NULL;
  char *a = "Hello";
  char *b = "World";
  char *c = "42";
  char *d = "21";
  char *e = "7";
  char *expected[] = {"21", "42", "7", "Hello", "World"};

  ft_list_push_front(&list, a);
  ft_list_push_front(&list, b);
  ft_list_push_front(&list, c);
  ft_list_push_front(&list, d);
  ft_list_push_front(&list, e);

  ft_list_sort(&list, &strcmp);

  t_list *tmp = list;
  for (int i = 0; i < 5; i++) {
    ASSERT_EQ(strcmp((char *)tmp->data, expected[i]), 0);
    tmp = tmp->next;
  }

  free_list(list);
}
