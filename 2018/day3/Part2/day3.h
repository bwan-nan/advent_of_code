/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   day3.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bwan-nan <bwan-nan@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/12/17 18:43:36 by bwan-nan          #+#    #+#             */
/*   Updated: 2018/12/17 19:20:39 by bwan-nan         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef DAY3_H
#define DAY3_H

typedef struct		s_claim
{
	int		claim_number;
	int		x_offset;
	int		y_offset;
	int		width;
	int		height;
	struct s_claim	*next;
}			t_claim;

void		load_claim(t_claim **claims_list, char *line);
int		find_the_one(t_claim *claims_list, char **map);
void		del_claims_list(t_claim *claims_list);
#endif
