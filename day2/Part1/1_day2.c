/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   1_day2.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/06 12:20:19 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/06 18:45:57 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../libft/libft.h"
#include <unistd.h>
#include <fcntl.h>

static int		checksum(int a, int b)
{
	return (a * b);
}

static void		count_it_all(char *str, int *a, int *b)
{
	int		fd;
	char	*line;
	int		i;
	int		count1;
	int		count2;
	int		alphabet[26];

	line = NULL;
	i = 0;
	while (i < 26)
		alphabet[i++] = 0;
	fd = open(str, O_RDONLY);
	while (get_next_line(fd, &line))
	{
		i = 0;
		while (line[i])
		{
			alphabet[line[i] - 97]++;
			i++;
		}
		i = 0;
		count1 = 0;
		count2 = 0;
		while (i < 26)
		{
			if (alphabet[i] == 2 && count1 == 0)
			{
				count1++;
				(*a)++;
			}
			else if (alphabet[i] == 3 && count2 == 0)
			{
				count2++;
				(*b)++;
			}
			alphabet[i] = 0;
			i++;
		}
		ft_strdel(&line);
	}
	close (fd);
}

int				main(int ac, char **av)
{
	int		double_letters;
	int		triple_letters;
	int		result;

	double_letters = 0;
	triple_letters = 0;
	if (ac == 2)
	{
		count_it_all(av[1], &double_letters, &triple_letters);	
		result = checksum(double_letters, triple_letters);
		ft_putstr("result = ");
		ft_putnbr(result);
		ft_putchar('\n');
	}
	return (0);
}
