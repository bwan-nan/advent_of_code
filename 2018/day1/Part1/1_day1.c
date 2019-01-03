/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   1_day1.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/03 17:03:35 by bwan-nan          #+#    #+#             */
/*   Updated: 2019/01/03 11:10:39 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>
#include "../../libft/libft.h"
#include <fcntl.h>

int			main(int ac, char **av)
{
	char	*line;;
	int	*new_tab;
	int	result;
	int	fd;

	result = 0;
	if (ac == 2)
	{
		fd = open(av[1], O_RDONLY);
		while (get_next_line(fd, &line))
			result += ft_atoi(line);
		close(fd);
		ft_putnbr(result);
	}
	else
		ft_putstr("usage: ./p1 day1_input.txt");
	ft_putchar('\n');
	return (0);
}
